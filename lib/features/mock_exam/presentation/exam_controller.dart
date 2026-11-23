import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/failures.dart';
import '../../../core/providers.dart';
import '../../../core/utils/formatters.dart';
import '../../learning/domain/learning_models.dart';
import '../../learning/presentation/progress_providers.dart';
import '../../questions/domain/question.dart';
import '../../questions/domain/question_bank.dart';
import '../data/exam_repository.dart';

class ExamSession {
  const ExamSession({
    required this.exam,
    required this.questions,
    required this.answers,
    required this.flags,
    required this.index,
  });

  final StoredExam exam;
  final List<Question> questions;
  final Map<String, List<int>> answers;
  final Set<String> flags;
  final int index;

  Question get current => questions[index];
  List<int> selectionFor(String id) => answers[id] ?? const [];
  bool isAnswered(Question q) => selectionFor(q.id).isNotEmpty;
  int get answeredCount => questions.where(isAnswered).length;
  int get unansweredCount => questions.length - answeredCount;
  List<int> orderFor(Question q) => exam.optionOrder[q.id] ?? List.generate(q.options.length, (i) => i);

  ExamSession copyWith({Map<String, List<int>>? answers, Set<String>? flags, int? index}) => ExamSession(
        exam: exam,
        questions: questions,
        answers: answers ?? this.answers,
        flags: flags ?? this.flags,
        index: index ?? this.index,
      );
}

final examControllerProvider = AsyncNotifierProvider<ExamController, ExamSession?>(ExamController.new);

class ExamController extends AsyncNotifier<ExamSession?> {
  DateTime _now() => ref.read(clockProvider)();

  @override
  Future<ExamSession?> build() async {
    final bank = await ref.watch(questionBankProvider.future);
    final active = await ref.read(examRepositoryProvider).active();
    return active == null ? null : _sessionFrom(active, bank);
  }

  ExamSession _sessionFrom(StoredExam exam, QuestionBank bank) => ExamSession(
        exam: exam,
        questions: bank.resolve(exam.questionIds),
        answers: {for (final e in exam.answers.entries) e.key: List.of(e.value)},
        flags: {...exam.flags},
        index: exam.currentIndex.clamp(0, exam.questionIds.length - 1),
      );

  /// Starts a new mock exam, or returns the one already in progress.
  Future<ExamSession> start() async {
    final existing = state.value;
    if (existing != null) return existing;
    final bank = await ref.read(questionBankProvider.future);
    final repo = ref.read(examRepositoryProvider);
    final ids = ref.read(examEngineProvider).buildExam(
          bank.questions,
          recentExamQuestionIds: await repo.recentQuestionIds(),
        );
    final order = buildOptionOrder({for (final id in ids) id: bank[id].options.length});
    final exam = await repo.create(questionIds: ids, optionOrder: order, startedAt: _now());
    final session = _sessionFrom(exam, bank);
    state = AsyncData(session);
    return session;
  }

  Future<void> _persist(ExamSession s) => ref
      .read(examRepositoryProvider)
      .saveProgress(s.exam.id, answers: s.answers, flags: s.flags, currentIndex: s.index);

  bool get isExpired {
    final s = state.value;
    return s != null && ref.read(examEngineProvider).isExpired(s.exam.deadline, _now());
  }

  Duration get remaining {
    final s = state.value;
    if (s == null) return Duration.zero;
    return ref.read(examEngineProvider).remaining(s.exam.deadline, _now());
  }

  Future<void> toggleOption(String questionId, int originalIndex) async {
    final s = state.value;
    if (s == null) return;
    if (isExpired) throw const RuleViolation('Time is up.');
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

  Future<void> toggleFlag(String questionId) async {
    final s = state.value;
    if (s == null) return;
    final flags = {...s.flags};
    if (!flags.remove(questionId)) flags.add(questionId);
    final next = s.copyWith(flags: flags);
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

  /// Scores and stores the exam. Called on manual submit or automatically when time expires.
  Future<int> submit() async {
    final s = state.value;
    if (s == null) throw const RuleViolation('No exam in progress');
    final now = _now();
    final end = now.isAfter(s.exam.deadline) ? s.exam.deadline : now;
    final outcome = ref.read(examEngineProvider).score(s.questions, s.answers, timeUsed: end.difference(s.exam.startedAt));
    final results = [
      for (final q in s.questions)
        QuestionResult(question: q, selected: s.selectionFor(q.id), correct: q.isAnsweredCorrectly(s.selectionFor(q.id))),
    ];
    await ref.read(progressRepositoryProvider).recordAnswers(results, source: 'exam');
    await ref.read(examRepositoryProvider).complete(s.exam.id, outcome: outcome, answers: s.answers, completedAt: now);
    state = const AsyncData(null);
    ref.read(dataVersionProvider.notifier).bump();
    return s.exam.id;
  }
}

final examByIdProvider = FutureProvider.family<StoredExam, int>((ref, id) async {
  ref.watch(dataVersionProvider);
  final exam = await ref.read(examRepositoryProvider).byId(id);
  if (exam == null) throw StateError('Exam $id not found');
  return exam;
});
