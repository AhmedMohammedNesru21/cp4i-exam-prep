import 'dart:math';

import '../../../core/constants/app_constants.dart';
import '../../learning/domain/learning_models.dart';
import '../../questions/domain/question.dart';

enum PracticeMode {
  category('practice-category', 'Category Practice', 'Practice any domain without affecting mastery.'),
  random('practice-random', 'Random Practice', 'Five random questions from the whole bank.'),
  advanced('practice-advanced', 'Advanced Practice', 'Advanced and expert questions only.'),
  scenario('practice-scenario', 'Scenario-Based Practice', 'Architecture scenarios and design decisions.'),
  troubleshooting('practice-troubleshooting', 'Troubleshooting Practice', 'Diagnose failures across CP4I.'),
  weakAreas('practice-weak', 'Weak-Area Practice', 'Questions from the concepts you miss most.'),
  bookmarked('practice-bookmarks', 'Bookmarked Questions', 'Questions you saved for later.'),
  incorrect('practice-incorrect', 'Incorrect Questions', 'Questions whose last answer was wrong.'),
  advancedRevision('practice-revision', 'Advanced Revision', 'Expert questions plus previously missed ones.');

  const PracticeMode(this.code, this.title, this.description);
  final String code;
  final String title;
  final String description;

  static PracticeMode? fromCode(String code) {
    for (final m in values) {
      if (m.code == code) return m;
    }
    return null;
  }
}

/// Builds practice rounds. Practice never affects category mastery, and avoids repeating
/// questions until the eligible pool has been exhausted.
class PracticeSelector {
  PracticeSelector({Random? random}) : _random = random ?? Random();
  final Random _random;

  List<Question> eligiblePool({
    required PracticeMode mode,
    required List<Question> bank,
    required Map<String, QuestionHistory> history,
    required Set<String> bookmarkedIds,
    required Set<String> weakConceptKeys,
    String? categoryId,
  }) {
    bool weak(Question q) => weakConceptKeys.contains('${q.categoryId}|${q.technicalConcept}');
    final scoped = categoryId == null ? bank : bank.where((q) => q.categoryId == categoryId).toList();
    return switch (mode) {
      PracticeMode.category => scoped,
      PracticeMode.random => scoped,
      PracticeMode.advanced => scoped.where((q) => q.difficulty.level >= 3).toList(),
      PracticeMode.scenario =>
        scoped.where((q) => q.style == QuestionStyle.scenario || q.style == QuestionStyle.design).toList(),
      PracticeMode.troubleshooting => scoped.where((q) => q.style == QuestionStyle.troubleshooting).toList(),
      PracticeMode.weakAreas => scoped.where(weak).toList(),
      PracticeMode.bookmarked => scoped.where((q) => bookmarkedIds.contains(q.id)).toList(),
      PracticeMode.incorrect => scoped.where((q) {
          final h = history[q.id];
          return h != null && !h.lastCorrect;
        }).toList(),
      PracticeMode.advancedRevision => scoped.where((q) {
          final h = history[q.id];
          return q.difficulty == Difficulty.expert || (h != null && h.everMissed) || weak(q);
        }).toList(),
    };
  }

  /// Picks up to five questions: unseen first, then least recently answered; weak concepts and
  /// recently missed questions get a boost in revision-oriented modes.
  List<String> select({
    required PracticeMode mode,
    required List<Question> bank,
    required Map<String, QuestionHistory> history,
    required Set<String> bookmarkedIds,
    required Set<String> weakConceptKeys,
    String? categoryId,
    int size = AppConstants.roundSize,
  }) {
    final pool = eligiblePool(
      mode: mode,
      bank: bank,
      history: history,
      bookmarkedIds: bookmarkedIds,
      weakConceptKeys: weakConceptKeys,
      categoryId: categoryId,
    );
    if (pool.isEmpty) return const [];

    final now = DateTime.now();
    double priority(Question q) {
      final h = history[q.id] ?? const QuestionHistory();
      var p = _random.nextDouble();
      if (h.unseen) {
        p += 1000; // exhaust unseen questions before repeating any
      } else {
        final age = now.difference(h.lastAnsweredAt ?? now).inMinutes;
        p += min(500, age / 60); // older answers rank higher
        if (!h.lastCorrect) p += 50;
      }
      if (weakConceptKeys.contains('${q.categoryId}|${q.technicalConcept}')) p += 25;
      return p;
    }

    final ranked = [for (final q in pool) (q, priority(q))]..sort((a, b) => b.$2.compareTo(a.$2));
    final ids = ranked.take(size).map((e) => e.$1.id).toList()..shuffle(_random);
    return ids;
  }
}
