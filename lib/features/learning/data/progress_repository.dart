import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../domain/learning_models.dart';

/// Answer history, weak concepts and category mastery persistence.
class ProgressRepository {
  ProgressRepository(this._db, {DateTime Function()? clock}) : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _now;

  Future<Map<String, QuestionHistory>> questionHistory() async {
    final rows = await _db.customSelect(
      'SELECT ua.question_id AS qid, COUNT(*) AS attempts, '
      'SUM(CASE WHEN ua.is_correct = 1 THEN 0 ELSE 1 END) AS wrong, '
      'MAX(ua.answered_at) AS last_at, '
      '(SELECT u2.is_correct FROM user_answers u2 WHERE u2.question_id = ua.question_id '
      ' ORDER BY u2.id DESC LIMIT 1) AS last_ok '
      'FROM user_answers ua GROUP BY ua.question_id',
      readsFrom: {_db.userAnswers},
    ).get();
    return {
      for (final r in rows)
        r.read<String>('qid'): QuestionHistory(
          attempts: r.read<int>('attempts'),
          wrong: r.read<int>('wrong'),
          lastAnsweredAt: r.read<DateTime?>('last_at'),
          lastCorrect: r.read<bool>('last_ok'),
        ),
    };
  }

  /// Persists answers and updates the weak-concept tracker in one transaction.
  Future<void> recordAnswers(List<QuestionResult> results, {required String source}) {
    return _db.transaction(() async {
      final now = _now();
      for (final r in results) {
        final previous = await (_db.selectOnly(_db.userAnswers)
              ..addColumns([_db.userAnswers.id.count()])
              ..where(_db.userAnswers.questionId.equals(r.question.id)))
            .map((row) => row.read(_db.userAnswers.id.count()) ?? 0)
            .getSingle();
        await _db.into(_db.userAnswers).insert(UserAnswersCompanion.insert(
              questionId: r.question.id,
              selectedAnswersJson: jsonEncode(r.selected),
              isCorrect: r.correct,
              attemptNumber: previous + 1,
              source: source,
              answeredAt: now,
            ));
        await _updateConcept(r.question.categoryId, r.question.technicalConcept, r.correct, now);
      }
    });
  }

  Future<void> _updateConcept(String categoryId, String concept, bool correct, DateTime now) async {
    final existing = await (_db.select(_db.weakConcepts)
          ..where((t) => t.categoryId.equals(categoryId) & t.conceptName.equals(concept)))
        .getSingleOrNull();
    if (existing == null) {
      if (correct) return; // only concepts that have been missed are tracked
      await _db.into(_db.weakConcepts).insert(WeakConceptsCompanion.insert(
            conceptName: concept,
            categoryId: categoryId,
            errorCount: const Value(1),
            lastMissedAt: Value(now),
          ));
      return;
    }
    if (correct) {
      final streak = existing.correctStreak + 1;
      await (_db.update(_db.weakConcepts)..where((t) => t.id.equals(existing.id))).write(WeakConceptsCompanion(
        correctStreak: Value(streak),
        masteryStatus: Value(streak >= AppConstants.conceptRecoveryStreak ? 'mastered' : 'improving'),
      ));
    } else {
      await (_db.update(_db.weakConcepts)..where((t) => t.id.equals(existing.id))).write(WeakConceptsCompanion(
        errorCount: Value(existing.errorCount + 1),
        correctStreak: const Value(0),
        lastMissedAt: Value(now),
        masteryStatus: const Value('weak'),
      ));
    }
  }

  Future<List<WeakConcept>> weakConcepts({bool includeMastered = false}) {
    final q = _db.select(_db.weakConcepts)
      ..orderBy([(t) => OrderingTerm.desc(t.errorCount), (t) => OrderingTerm.desc(t.lastMissedAt)]);
    if (!includeMastered) q.where((t) => t.masteryStatus.equals('mastered').not());
    return q.get();
  }

  /// Keys "categoryId|concept" for concepts that are not yet recovered.
  Future<Set<String>> activeWeakConceptKeys() async =>
      {for (final w in await weakConcepts()) '${w.categoryId}|${w.conceptName}'};

  Future<Map<String, int>> conceptErrors(String categoryId) async {
    final rows = await (_db.select(_db.weakConcepts)
          ..where((t) => t.categoryId.equals(categoryId) & t.masteryStatus.equals('mastered').not()))
        .get();
    return {for (final r in rows) r.conceptName: r.errorCount};
  }

  Future<Map<String, CategoryMastery>> allMastery() async {
    final rows = await _db.select(_db.categoryProgress).get();
    final totals = {for (final c in await _db.select(_db.categories).get()) c.id: c.totalQuestions};
    return {
      for (final r in rows)
        r.categoryId: CategoryMastery(
          categoryId: r.categoryId,
          totalQuestions: totals[r.categoryId] ?? 0,
          coveredIds: (jsonDecode(r.coveredQuestionIdsJson) as List<dynamic>).cast<String>().toSet(),
          roundsPassed: r.roundsPassed,
          roundsFailed: r.roundsFailed,
          status: MasteryStatus.fromCode(r.masteryStatus),
        ),
    };
  }

  Future<CategoryMastery> mastery(String categoryId) async =>
      (await allMastery())[categoryId] ??
      CategoryMastery(
        categoryId: categoryId,
        totalQuestions: 0,
        coveredIds: const {},
        roundsPassed: 0,
        roundsFailed: 0,
        status: MasteryStatus.notStarted,
      );

  Future<void> saveMastery(CategoryMastery m) =>
      (_db.update(_db.categoryProgress)..where((t) => t.categoryId.equals(m.categoryId))).write(
        CategoryProgressCompanion(
          questionsCovered: Value(m.covered),
          roundsPassed: Value(m.roundsPassed),
          roundsFailed: Value(m.roundsFailed),
          completionPercentage: Value(m.completion * 100),
          masteryStatus: Value(m.status.code),
          coveredQuestionIdsJson: Value(jsonEncode(m.coveredIds.toList()..sort())),
        ),
      );

  /// Aggregate counters for the dashboard.
  Future<AnswerTotals> totals() async {
    final r = await _db.customSelect(
      'SELECT COUNT(*) AS answers, COALESCE(SUM(is_correct), 0) AS correct, '
      'COUNT(DISTINCT question_id) AS distinct_q FROM user_answers',
      readsFrom: {_db.userAnswers},
    ).getSingle();
    return AnswerTotals(
      answers: r.read<int>('answers'),
      correct: r.read<int>('correct'),
      distinctQuestions: r.read<int>('distinct_q'),
    );
  }

  /// Answer dates (local) used for the study streak and accuracy trend.
  Future<List<DailyActivity>> dailyActivity({int days = 30}) async {
    final since = _now().subtract(Duration(days: days));
    final rows = await (_db.select(_db.userAnswers)..where((t) => t.answeredAt.isBiggerOrEqualValue(since))).get();
    final map = <DateTime, List<int>>{};
    for (final r in rows) {
      final d = DateTime(r.answeredAt.year, r.answeredAt.month, r.answeredAt.day);
      final bucket = map.putIfAbsent(d, () => [0, 0]);
      bucket[0]++;
      if (r.isCorrect) bucket[1]++;
    }
    final list = [for (final e in map.entries) DailyActivity(day: e.key, answers: e.value[0], correct: e.value[1])]
      ..sort((a, b) => a.day.compareTo(b.day));
    return list;
  }

  /// Consecutive days with at least one answer, ending today (or yesterday).
  Future<int> studyStreak() async {
    final days = (await dailyActivity(days: 400)).map((d) => d.day).toSet();
    final now = _now();
    var cursor = DateTime(now.year, now.month, now.day);
    if (!days.contains(cursor)) cursor = cursor.subtract(const Duration(days: 1));
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  Future<List<UserAnswer>> recentAnswers({int limit = 50}) => (_db.select(_db.userAnswers)
        ..orderBy([(t) => OrderingTerm.desc(t.id)])
        ..limit(limit))
      .get();
}

class AnswerTotals {
  const AnswerTotals({required this.answers, required this.correct, required this.distinctQuestions});
  final int answers;
  final int correct;
  final int distinctQuestions;
  double get accuracy => answers == 0 ? 0 : correct * 100 / answers;
}

class DailyActivity {
  const DailyActivity({required this.day, required this.answers, required this.correct});
  final DateTime day;
  final int answers;
  final int correct;
  double get accuracy => answers == 0 ? 0 : correct * 100 / answers;
}
