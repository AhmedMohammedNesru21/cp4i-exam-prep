import 'dart:math';

import '../../../core/constants/app_constants.dart';
import '../../questions/domain/question.dart';

class CategoryScore {
  const CategoryScore({required this.correct, required this.total});
  final int correct;
  final int total;
  double get percentage => total == 0 ? 0 : correct * 100 / total;

  Map<String, int> toJson() => {'c': correct, 't': total};
  factory CategoryScore.fromJson(Map<String, dynamic> j) =>
      CategoryScore(correct: j['c'] as int, total: j['t'] as int);
}

class ExamOutcome {
  const ExamOutcome({
    required this.correct,
    required this.total,
    required this.unanswered,
    required this.byCategory,
    required this.weakConcepts,
    required this.timeUsed,
  });

  final int correct;
  final int total;
  final int unanswered;
  final Map<String, CategoryScore> byCategory;

  /// Concepts answered incorrectly, most frequent first.
  final List<MapEntry<String, int>> weakConcepts;
  final Duration timeUsed;

  int get incorrect => total - correct;
  bool get passed => correct >= AppConstants.examPassMark;
  double get percentage => total == 0 ? 0 : correct * 100 / total;

  /// Categories below 70% ordered from weakest.
  List<String> get recommendedRevision {
    final entries = byCategory.entries.where((e) => e.value.total > 0 && e.value.percentage < 70).toList()
      ..sort((a, b) => a.value.percentage.compareTo(b.value.percentage));
    return [for (final e in entries) e.key];
  }
}

/// Builds and scores weighted 64-question mock exams.
class ExamEngine {
  ExamEngine({Random? random}) : _random = random ?? Random();
  final Random _random;

  /// Weighted distribution per the blueprint. Questions used in [recentExamQuestionIds]
  /// are deprioritized so consecutive mock exams differ as much as possible.
  List<String> buildExam(List<Question> bank, {Set<String> recentExamQuestionIds = const {}}) {
    final ids = <String>[];
    for (final c in kCategories) {
      final pool = bank.where((q) => q.categoryId == c.id).toList()..shuffle(_random);
      pool.sort((a, b) {
        final ra = recentExamQuestionIds.contains(a.id) ? 1 : 0;
        final rb = recentExamQuestionIds.contains(b.id) ? 1 : 0;
        return ra.compareTo(rb);
      });
      if (pool.length < c.examQuestions) {
        throw StateError('Not enough questions in ${c.id} for a mock exam');
      }
      ids.addAll(pool.take(c.examQuestions).map((q) => q.id));
    }
    assert(ids.length == AppConstants.examQuestionCount);
    ids.shuffle(_random);
    return ids;
  }

  ExamOutcome score(
    List<Question> questions,
    Map<String, List<int>> answers, {
    required Duration timeUsed,
  }) {
    var correct = 0;
    var unanswered = 0;
    final byCat = <String, List<int>>{for (final c in kCategories) c.id: [0, 0]};
    final weak = <String, int>{};
    for (final q in questions) {
      final sel = answers[q.id] ?? const <int>[];
      if (sel.isEmpty) unanswered++;
      final ok = q.isAnsweredCorrectly(sel);
      final bucket = byCat.putIfAbsent(q.categoryId, () => [0, 0]);
      bucket[1]++;
      if (ok) {
        correct++;
        bucket[0]++;
      } else {
        weak.update(q.technicalConcept, (v) => v + 1, ifAbsent: () => 1);
      }
    }
    final weakList = weak.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return ExamOutcome(
      correct: correct,
      total: questions.length,
      unanswered: unanswered,
      byCategory: {for (final e in byCat.entries) e.key: CategoryScore(correct: e.value[0], total: e.value[1])},
      weakConcepts: weakList,
      timeUsed: timeUsed,
    );
  }

  /// Remaining time, never negative.
  Duration remaining(DateTime deadline, DateTime now) {
    final d = deadline.difference(now);
    return d.isNegative ? Duration.zero : d;
  }

  bool isExpired(DateTime deadline, DateTime now) => !now.isBefore(deadline);
}
