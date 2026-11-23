/// Value objects shared by the learning, practice and exam engines.
library;

import '../../questions/domain/question.dart';

/// Per-question answer history summary used for adaptive selection.
class QuestionHistory {
  const QuestionHistory({
    this.attempts = 0,
    this.wrong = 0,
    this.lastAnsweredAt,
    this.lastCorrect = false,
  });

  final int attempts;
  final int wrong;
  final DateTime? lastAnsweredAt;
  final bool lastCorrect;

  bool get everMissed => wrong > 0;
  bool get unseen => attempts == 0;
}

enum MasteryStatus {
  notStarted('not_started', 'Not Started'),
  inProgress('in_progress', 'In Progress'),
  retryRequired('retry_required', 'Retry Required'),
  mastered('mastered', 'Mastered');

  const MasteryStatus(this.code, this.label);
  final String code;
  final String label;

  static MasteryStatus fromCode(String code) =>
      MasteryStatus.values.firstWhere((s) => s.code == code, orElse: () => MasteryStatus.notStarted);
}

/// Progress of one category in the structured learning journey.
class CategoryMastery {
  const CategoryMastery({
    required this.categoryId,
    required this.totalQuestions,
    required this.coveredIds,
    required this.roundsPassed,
    required this.roundsFailed,
    required this.status,
  });

  final String categoryId;
  final int totalQuestions;

  /// Questions that were part of a passed (5/5) round.
  final Set<String> coveredIds;
  final int roundsPassed;
  final int roundsFailed;
  final MasteryStatus status;

  int get covered => coveredIds.length;
  double get completion => totalQuestions == 0 ? 0 : covered / totalQuestions;
  bool get isMastered => status == MasteryStatus.mastered;

  /// Minimum number of further passed rounds needed to cover the category.
  int get roundsRemaining => ((totalQuestions - covered) / 5).ceil();
}

/// Result of scoring one question.
class QuestionResult {
  const QuestionResult({required this.question, required this.selected, required this.correct});
  final Question question;
  final List<int> selected;
  final bool correct;
}

/// Result of a five-question round (learning or practice).
class RoundOutcome {
  const RoundOutcome({required this.results, required this.passed});

  final List<QuestionResult> results;

  /// Learning rounds pass ONLY with a perfect score.
  final bool passed;

  int get score => results.where((r) => r.correct).length;
  int get total => results.length;

  /// Distinct technical concepts answered incorrectly in this round.
  List<String> get weakConcepts {
    final seen = <String>{};
    return [
      for (final r in results)
        if (!r.correct && seen.add(r.question.technicalConcept)) r.question.technicalConcept,
    ];
  }
}
