import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../mock_exam/data/exam_repository.dart';
import '../../questions/domain/question.dart';
import '../data/progress_repository.dart';
import '../data/round_repository.dart';
import '../domain/learning_models.dart';

/// Bumped after every mutation so read models refresh (no DB streams needed).
final dataVersionProvider = NotifierProvider<DataVersion, int>(DataVersion.new);

class DataVersion extends Notifier<int> {
  @override
  int build() => 0;
  void bump() => state++;
}

final masteryMapProvider = FutureProvider<Map<String, CategoryMastery>>((ref) async {
  ref.watch(dataVersionProvider);
  await ref.watch(questionBankProvider.future);
  return ref.read(progressRepositoryProvider).allMastery();
});

final questionHistoryProvider = FutureProvider<Map<String, QuestionHistory>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(progressRepositoryProvider).questionHistory();
});

final weakConceptsProvider = FutureProvider<List<WeakConcept>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(progressRepositoryProvider).weakConcepts(includeMastered: true);
});

final bookmarkIdsProvider = FutureProvider<List<String>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(bookmarkRepositoryProvider).orderedIds();
});

final completedExamsProvider = FutureProvider<List<StoredExam>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(examRepositoryProvider).completed();
});

final roundHistoryProvider = FutureProvider<List<StoredRound>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(roundRepositoryProvider).history();
});

final dailyActivityProvider = FutureProvider<List<DailyActivity>>((ref) async {
  ref.watch(dataVersionProvider);
  return ref.read(progressRepositoryProvider).dailyActivity(days: 30);
});

/// Accuracy per category derived from the full answer history.
class CategoryAccuracy {
  const CategoryAccuracy(this.categoryId, this.attempts, this.correct);
  final String categoryId;
  final int attempts;
  final int correct;
  double get accuracy => attempts == 0 ? 0 : correct * 100 / attempts;
}

class DashboardData {
  const DashboardData({
    required this.totalQuestions,
    required this.totals,
    required this.mastery,
    required this.studyStreak,
    required this.masteryStreak,
    required this.examAttempts,
    required this.lastExam,
    required this.categoryAccuracy,
    required this.nextCategoryId,
    required this.activeRound,
  });

  final int totalQuestions;
  final AnswerTotals totals;
  final Map<String, CategoryMastery> mastery;
  final int studyStreak;

  /// Consecutive passed (5/5) learning rounds.
  final int masteryStreak;
  final int examAttempts;
  final StoredExam? lastExam;
  final Map<String, CategoryAccuracy> categoryAccuracy;
  final String? nextCategoryId;
  final StoredRound? activeRound;

  int get categoriesMastered => mastery.values.where((m) => m.isMastered).length;
  int get questionsCovered => mastery.values.fold(0, (s, m) => s + m.covered);
  int get questionsRemaining => totalQuestions - totals.distinctQuestions;
  double get overallProgress => totalQuestions == 0 ? 0 : questionsCovered * 100 / totalQuestions;

  /// Categories with at least 5 attempts, weakest first.
  List<CategoryAccuracy> get weakestCategories {
    final list = categoryAccuracy.values.where((c) => c.attempts >= 5).toList()
      ..sort((a, b) => a.accuracy.compareTo(b.accuracy));
    return list.take(3).toList();
  }
}

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  ref.watch(dataVersionProvider);
  final bank = await ref.watch(questionBankProvider.future);
  final progress = ref.read(progressRepositoryProvider);
  final history = await progress.questionHistory();
  final exams = await ref.read(examRepositoryProvider).completed();
  final rounds = await ref.read(roundRepositoryProvider).history(limit: 500);
  final mastery = await progress.allMastery();

  final accuracy = <String, List<int>>{for (final c in kCategories) c.id: [0, 0]};
  for (final e in history.entries) {
    final Question? q = bank.byId(e.key);
    if (q == null) continue;
    final bucket = accuracy[q.categoryId]!;
    bucket[0] += e.value.attempts;
    bucket[1] += e.value.attempts - e.value.wrong;
  }
  var masteryStreak = 0;
  for (final r in rounds.where((r) => r.isLearning)) {
    if (r.status != 'passed') break;
    masteryStreak++;
  }

  return DashboardData(
    totalQuestions: bank.length,
    totals: await progress.totals(),
    mastery: mastery,
    studyStreak: await progress.studyStreak(),
    masteryStreak: masteryStreak,
    examAttempts: exams.length,
    lastExam: exams.isEmpty ? null : exams.first,
    categoryAccuracy: {for (final e in accuracy.entries) e.key: CategoryAccuracy(e.key, e.value[0], e.value[1])},
    nextCategoryId: ref.read(masteryEngineProvider).nextCategoryToStudy(mastery),
    activeRound: await ref.read(roundRepositoryProvider).active(),
  );
});

/// A completed round re-hydrated for result/explanation screens (survives restarts).
class RoundReview {
  const RoundReview({required this.round, required this.results, required this.mastery});
  final StoredRound round;
  final List<QuestionResult> results;
  final CategoryMastery? mastery;
  int get score => results.where((r) => r.correct).length;
  bool get passed => round.status == 'passed' || (!round.isLearning && score == results.length);
  List<String> get weakConcepts {
    final seen = <String>{};
    return [
      for (final r in results)
        if (!r.correct && seen.add(r.question.technicalConcept)) r.question.technicalConcept,
    ];
  }
}

final roundReviewProvider = FutureProvider.family<RoundReview, int>((ref, roundId) async {
  ref.watch(dataVersionProvider);
  final bank = await ref.watch(questionBankProvider.future);
  final round = await ref.read(roundRepositoryProvider).byId(roundId);
  if (round == null) throw StateError('Round $roundId not found');
  final results = [
    for (final id in round.questionIds)
      QuestionResult(
        question: bank[id],
        selected: round.answers[id] ?? const [],
        correct: bank[id].isAnsweredCorrectly(round.answers[id] ?? const []),
      ),
  ];
  final mastery = round.categoryId != null && round.isLearning
      ? await ref.read(progressRepositoryProvider).mastery(round.categoryId!)
      : null;
  return RoundReview(round: round, results: results, mastery: mastery);
});
