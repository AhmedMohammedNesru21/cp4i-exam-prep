import 'dart:math';

import '../../../core/constants/app_constants.dart';
import '../../questions/domain/question.dart';
import 'learning_models.dart';

/// The five-question mastery engine.
///
/// Rules:
///  * every learning round contains exactly [AppConstants.roundSize] questions;
///  * a round passes only with 5/5;
///  * questions in a passed round become "covered";
///  * a category is mastered only when every one of its questions is covered;
///  * the next category unlocks only when the previous one is mastered;
///  * failed rounds are retried with a NEW set that prioritizes missed questions and weak concepts.
class MasteryEngine {
  MasteryEngine({Random? random}) : _random = random ?? Random();

  final Random _random;
  static const int roundSize = AppConstants.roundSize;

  /// Strict pass rule.
  bool isPass(int score, int total) => total == roundSize && score == roundSize;

  RoundOutcome scoreLearningRound(List<Question> questions, Map<String, List<int>> answers) {
    final results = [
      for (final q in questions)
        QuestionResult(
          question: q,
          selected: List.unmodifiable(answers[q.id] ?? const <int>[]),
          correct: q.isAnsweredCorrectly(answers[q.id] ?? const <int>[]),
        ),
    ];
    final score = results.where((r) => r.correct).length;
    return RoundOutcome(results: results, passed: isPass(score, results.length));
  }

  /// Selects the next learning round for a category.
  ///
  /// [lastRoundIds]/[lastRoundMissed] describe the most recent round in this category, used to
  /// prioritize missed questions and to make sure a retry is not an identical set.
  List<String> selectLearningRound({
    required List<Question> categoryQuestions,
    required Set<String> coveredIds,
    required Map<String, QuestionHistory> history,
    required Map<String, int> conceptErrors,
    Set<String> lastRoundIds = const {},
    Set<String> lastRoundMissed = const {},
  }) {
    if (categoryQuestions.length < roundSize) {
      throw StateError('A category needs at least $roundSize questions.');
    }
    final uncovered = categoryQuestions.where((q) => !coveredIds.contains(q.id)).toList();
    final covered = categoryQuestions.where((q) => coveredIds.contains(q.id)).toList();

    double priority(Question q) {
      final h = history[q.id] ?? const QuestionHistory();
      var p = _random.nextDouble() * 10;
      if (lastRoundMissed.contains(q.id)) p += 100;
      p += min(40, (conceptErrors[q.technicalConcept] ?? 0) * 10).toDouble();
      if (h.everMissed && !h.lastCorrect) p += 30;
      if (h.unseen) p += 20;
      if (lastRoundIds.contains(q.id) && !lastRoundMissed.contains(q.id)) p -= 15;
      return p;
    }

    List<Question> ranked(List<Question> list, double Function(Question) score) {
      final scored = [for (final q in list) (q, score(q))]..sort((a, b) => b.$2.compareTo(a.$2));
      return [for (final s in scored) s.$1];
    }

    final List<Question> chosen;
    if (uncovered.isEmpty) {
      // Category already mastered: revision rounds favour previously missed and weak concepts.
      chosen = ranked(categoryQuestions, priority).take(roundSize).toList();
    } else {
      final primary = ranked(uncovered, priority);
      chosen = primary.take(roundSize).toList();
      if (chosen.length < roundSize) {
        // Final partial round: supplement with previously missed revision questions first.
        double revisionPriority(Question q) {
          final h = history[q.id] ?? const QuestionHistory();
          return (h.wrong * 20) +
              ((conceptErrors[q.technicalConcept] ?? 0) * 5) +
              _random.nextDouble() * 10 -
              (lastRoundIds.contains(q.id) ? 15 : 0);
        }

        chosen.addAll(ranked(covered, revisionPriority).take(roundSize - chosen.length));
      }
    }

    // Guarantee a retry is a different set whenever the pool allows it.
    final chosenIds = chosen.map((q) => q.id).toSet();
    if (lastRoundIds.isNotEmpty && chosenIds.length == lastRoundIds.length && chosenIds.containsAll(lastRoundIds)) {
      final alternatives = categoryQuestions.where((q) => !chosenIds.contains(q.id)).toList();
      if (alternatives.isNotEmpty) {
        // Replace the lowest-priority question that was answered correctly last time.
        final replaceable = chosen.lastWhere((q) => !lastRoundMissed.contains(q.id), orElse: () => chosen.last);
        final preferUncovered = alternatives.where((q) => !coveredIds.contains(q.id)).toList();
        final pool = preferUncovered.isNotEmpty ? preferUncovered : alternatives;
        chosen[chosen.indexOf(replaceable)] = pool[_random.nextInt(pool.length)];
      }
    }

    final ids = chosen.map((q) => q.id).toList()..shuffle(_random);
    assert(ids.length == roundSize && ids.toSet().length == roundSize);
    return ids;
  }

  /// Applies a completed learning round to the category's mastery state.
  CategoryMastery applyRound(CategoryMastery current, List<String> roundIds, bool passed) {
    final covered = {...current.coveredIds};
    if (passed) covered.addAll(roundIds);
    final status = covered.length >= current.totalQuestions
        ? MasteryStatus.mastered
        : passed
            ? MasteryStatus.inProgress
            : MasteryStatus.retryRequired;
    return CategoryMastery(
      categoryId: current.categoryId,
      totalQuestions: current.totalQuestions,
      coveredIds: covered,
      roundsPassed: current.roundsPassed + (passed ? 1 : 0),
      roundsFailed: current.roundsFailed + (passed ? 0 : 1),
      // Once mastered, a later failed revision round never revokes mastery.
      status: current.isMastered ? MasteryStatus.mastered : status,
    );
  }

  /// Structured journey: category N is unlocked only when category N-1 is mastered.
  bool isUnlocked(String categoryId, Map<String, CategoryMastery> progress) {
    final ordered = [...kCategories]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final idx = ordered.indexWhere((c) => c.id == categoryId);
    if (idx <= 0) return idx == 0;
    return progress[ordered[idx - 1].id]?.isMastered ?? false;
  }

  /// First category that is unlocked and not yet mastered (the "Continue Learning" target).
  String? nextCategoryToStudy(Map<String, CategoryMastery> progress) {
    final ordered = [...kCategories]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    for (final c in ordered) {
      if (!(progress[c.id]?.isMastered ?? false)) return c.id;
    }
    return null;
  }
}
