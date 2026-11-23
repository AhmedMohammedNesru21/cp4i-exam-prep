import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failures.dart';
import '../../../core/providers.dart';
import '../../../core/utils/formatters.dart';
import '../../practice/domain/practice_selector.dart';
import '../../questions/domain/question.dart';
import '../../questions/domain/question_bank.dart';
import '../data/round_repository.dart';
import 'progress_providers.dart';

/// In-memory view of the active learning/practice round.
class RoundSession {
  const RoundSession({
    required this.round,
    required this.questions,
    required this.answers,
    required this.index,
  });

  final StoredRound round;
  final List<Question> questions;

  /// questionId -> selected ORIGINAL option indexes.
  final Map<String, List<int>> answers;
  final int index;

  bool get isLearning => round.isLearning;
  Question get current => questions[index];
  bool get isFirst => index == 0;
  bool get isLast => index == questions.length - 1;
  List<int> selectionFor(String id) => answers[id] ?? const [];
  bool isComplete(Question q) => selectionFor(q.id).length == q.requiredSelections;
  bool get allAnswered => questions.every(isComplete);
  int get answeredCount => questions.where(isComplete).length;

  /// Display order of options for a question (falls back to original order).
  List<int> orderFor(Question q) => round.optionOrder[q.id] ?? List.generate(q.options.length, (i) => i);

  RoundSession copyWith({Map<String, List<int>>? answers, int? index}) => RoundSession(
        round: round,
        questions: questions,
        answers: answers ?? this.answers,
        index: index ?? this.index,
      );
}

/// Result returned after submitting a round, used for navigation.
class SubmittedRound {
  const SubmittedRound({required this.roundId, required this.passed, required this.newlyMastered});
  final int roundId;
  final bool passed;
  final bool newlyMastered;
}

final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, RoundSession?>(SessionController.new);

class SessionController extends AsyncNotifier<RoundSession?> {
  @override
  Future<RoundSession?> build() async {
    final bank = await ref.watch(questionBankProvider.future);
    final active = await ref.read(roundRepositoryProvider).active();
    if (active == null) return null;
    return _sessionFrom(active, bank);
  }

  RoundSession _sessionFrom(StoredRound round, QuestionBank bank) => RoundSession(
        round: round,
        questions: bank.resolve(round.questionIds),
        answers: {for (final e in round.answers.entries) e.key: List.of(e.value)},
        index: round.currentIndex.clamp(0, round.questionIds.length - 1),
      );

  /// Starts the next five-question mastery round for [categoryId].
  Future<void> startLearning(String categoryId) async {
    final bank = await ref.read(questionBankProvider.future);
    final progressRepo = ref.read(progressRepositoryProvider);
    final rounds = ref.read(roundRepositoryProvider);
    final engine = ref.read(masteryEngineProvider);
    final mastery = await progressRepo.allMastery();
    if (!engine.isUnlocked(categoryId, mastery)) {
      throw const RuleViolation('This category is locked. Master the previous category first.');
    }

    final last = await rounds.lastCompletedLearningRound(categoryId);
    final lastIds = last?.questionIds.toSet() ?? <String>{};
    final missed = <String>{
      if (last != null)
        for (final id in last.questionIds)
          if (!bank[id].isAnsweredCorrectly(last.answers[id] ?? const [])) id,
    };

    final ids = engine.selectLearningRound(
      categoryQuestions: bank.inCategory(categoryId),
      coveredIds: mastery[categoryId]?.coveredIds ?? const {},
      history: await progressRepo.questionHistory(),
      conceptErrors: await progressRepo.conceptErrors(categoryId),
      lastRoundIds: lastIds,
      lastRoundMissed: missed,
    );
    await _create(mode: 'learning', categoryId: categoryId, ids: ids, bank: bank);
  }

  /// Starts a practice round. Returns the number of questions (0 when the pool is empty).
  Future<int> startPractice(PracticeMode mode, {String? categoryId}) async {
    final bank = await ref.read(questionBankProvider.future);
    final progressRepo = ref.read(progressRepositoryProvider);
    final ids = ref.read(practiceSelectorProvider).select(
          mode: mode,
          bank: bank.questions,
          history: await progressRepo.questionHistory(),
          bookmarkedIds: await ref.read(bookmarkRepositoryProvider).ids(),
          weakConceptKeys: await progressRepo.activeWeakConceptKeys(),
          categoryId: categoryId,
        );
    if (ids.isEmpty) return 0;
    await _create(mode: mode.code, categoryId: categoryId, ids: ids, bank: bank);
    return ids.length;
  }

  Future<void> _create({
    required String mode,
    required String? categoryId,
    required List<String> ids,
    required QuestionBank bank,
  }) async {
    final rounds = ref.read(roundRepositoryProvider);
    await rounds.abandonActive();
    final order = buildOptionOrder({for (final id in ids) id: bank[id].options.length});
    final round = await rounds.create(mode: mode, categoryId: categoryId, questionIds: ids, optionOrder: order);
    state = AsyncData(_sessionFrom(round, bank));
  }

  Future<void> _persist(RoundSession s) =>
      ref.read(roundRepositoryProvider).saveProgress(s.round.id, s.answers, s.index);

  /// Selects (single-answer) or toggles (multiple-select) an ORIGINAL option index.
  Future<void> toggleOption(String questionId, int originalIndex) async {
    final s = state.value;
    if (s == null) return;
    final q = s.questions.firstWhere((q) => q.id == questionId);
    final current = List<int>.of(s.selectionFor(questionId));
    if (q.isMultiple) {
      if (current.contains(originalIndex)) {
        current.remove(originalIndex);
      } else if (current.length < q.requiredSelections) {
        current.add(originalIndex);
      }
    } else {
      current
        ..clear()
        ..add(originalIndex);
    }
    final next = s.copyWith(answers: {...s.answers, questionId: current});
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> goTo(int index) async {
    final s = state.value;
    if (s == null || index < 0 || index >= s.questions.length) return;
    final next = s.copyWith(index: index);
    state = AsyncData(next);
    await _persist(next);
  }

  /// Scores the round, records answers and weak concepts, and applies mastery rules.
  Future<SubmittedRound> submit() async {
    final s = state.value;
    if (s == null) throw const RuleViolation('No active round');
    if (s.isLearning && !s.allAnswered) {
      throw const RuleViolation('Answer all five questions before submitting.');
    }
    final engine = ref.read(masteryEngineProvider);
    final outcome = engine.scoreLearningRound(s.questions, s.answers);
    final progressRepo = ref.read(progressRepositoryProvider);
    await progressRepo.recordAnswers(outcome.results, source: s.isLearning ? 'learning' : 'practice');

    var newlyMastered = false;
    if (s.isLearning) {
      final categoryId = s.round.categoryId!;
      final before = await progressRepo.mastery(categoryId);
      final after = engine.applyRound(before, s.round.questionIds, outcome.passed);
      await progressRepo.saveMastery(after);
      newlyMastered = after.isMastered && !before.isMastered;
    }
    await ref.read(roundRepositoryProvider).complete(
          s.round.id,
          score: outcome.score,
          status: s.isLearning ? (outcome.passed ? 'passed' : 'failed') : 'completed',
          answers: s.answers,
        );
    state = const AsyncData(null);
    ref.read(dataVersionProvider.notifier).bump();
    return SubmittedRound(roundId: s.round.id, passed: outcome.passed, newlyMastered: newlyMastered);
  }


  Future<void> abandon() async {
    await ref.read(roundRepositoryProvider).abandonActive();
    state = const AsyncData(null);
    ref.read(dataVersionProvider.notifier).bump();
  }
}
