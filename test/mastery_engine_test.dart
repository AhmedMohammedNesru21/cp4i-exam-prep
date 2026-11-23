import 'dart:math';

import 'package:cp4i_exam_prep/core/constants/app_constants.dart';
import 'package:cp4i_exam_prep/core/utils/formatters.dart';
import 'package:cp4i_exam_prep/features/learning/domain/learning_models.dart';
import 'package:cp4i_exam_prep/features/learning/domain/mastery_engine.dart';
import 'package:cp4i_exam_prep/features/practice/domain/practice_selector.dart';
import 'package:cp4i_exam_prep/features/questions/domain/question.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

CategoryMastery fresh(String id) => CategoryMastery(
      categoryId: id,
      totalQuestions: testBank.inCategory(id).length,
      coveredIds: const {},
      roundsPassed: 0,
      roundsFailed: 0,
      status: MasteryStatus.notStarted,
    );

void main() {
  final engine = MasteryEngine(random: Random(42));
  final ovr = testBank.inCategory('ovr');

  test('1. a learning round loads exactly five unique questions from the category', () {
    final ids = engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {});
    expect(ids, hasLength(5));
    expect(ids.toSet(), hasLength(5));
    expect(ids.every((id) => testBank[id].categoryId == 'ovr'), isTrue);
  });

  test('2/3. correct and incorrect answers are scored correctly', () {
    final qs = testBank.resolve(engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {}));
    final outcome = engine.scoreLearningRound(qs, answerKey(qs, wrong: {qs[1].id, qs[3].id}));
    expect(outcome.score, 3);
    expect(outcome.results[1].correct, isFalse);
    expect(outcome.results[0].correct, isTrue);
    expect(outcome.weakConcepts, isNotEmpty);
  });

  test('4. 5/5 produces PASS', () {
    final qs = testBank.resolve(engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {}));
    final outcome = engine.scoreLearningRound(qs, answerKey(qs));
    expect(outcome.score, 5);
    expect(outcome.passed, isTrue);
  });

  test('5. 4/5 (and anything below) produces FAIL', () {
    final qs = testBank.resolve(engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {}));
    for (var wrongCount = 1; wrongCount <= 5; wrongCount++) {
      final outcome = engine.scoreLearningRound(qs, answerKey(qs, wrong: qs.take(wrongCount).map((q) => q.id).toSet()));
      expect(outcome.score, 5 - wrongCount);
      expect(outcome.passed, isFalse, reason: '${outcome.score}/5 must fail');
    }
    expect(engine.isPass(4, 5), isFalse);
    expect(engine.isPass(5, 5), isTrue);
  });

  test('16. multiple-select questions require all correct selections and nothing else', () {
    final multi = testBank.questions.firstWhere((q) => q.isMultiple);
    expect(multi.isAnsweredCorrectly(multi.correctAnswers), isTrue);
    expect(multi.isAnsweredCorrectly([multi.correctAnswers.first]), isFalse, reason: 'partial selection');
    final extra = List.generate(multi.options.length, (i) => i).firstWhere((i) => !multi.correctAnswers.contains(i));
    expect(multi.isAnsweredCorrectly([...multi.correctAnswers, extra]), isFalse, reason: 'extra selection');
  });

  test('6. a failed round never unlocks the next category and marks Retry Required', () {
    var m = fresh('ovr');
    final ids = ovr.take(5).map((q) => q.id).toList();
    m = engine.applyRound(m, ids, false);
    expect(m.status, MasteryStatus.retryRequired);
    expect(m.covered, 0);
    expect(engine.isUnlocked('cpa', {'ovr': m}), isFalse);
    expect(engine.isUnlocked('ovr', {'ovr': m}), isTrue);
  });

  test('7/8. retry generates a different set that prioritizes missed questions', () {
    final first = engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {});
    final missed = {first[0], first[2]};
    final retry = engine.selectLearningRound(
      categoryQuestions: ovr,
      coveredIds: {},
      history: {for (final id in missed) id: const QuestionHistory(attempts: 1, wrong: 1)},
      conceptErrors: {for (final id in missed) testBank[id].technicalConcept: 1},
      lastRoundIds: first.toSet(),
      lastRoundMissed: missed,
    );
    expect(retry.toSet(), isNot(equals(first.toSet())), reason: 'new set');
    expect(retry.toSet().containsAll(missed), isTrue, reason: 'missed questions prioritized');
  });

  test('retry is never an identical set even when every question was missed', () {
    final first = engine.selectLearningRound(categoryQuestions: ovr, coveredIds: {}, history: {}, conceptErrors: {});
    final retry = engine.selectLearningRound(
      categoryQuestions: ovr,
      coveredIds: {},
      history: {},
      conceptErrors: {},
      lastRoundIds: first.toSet(),
      lastRoundMissed: first.toSet(),
    );
    expect(retry.toSet(), isNot(equals(first.toSet())));
  });

  test('9/10. all category questions are covered before mastery; final partial round still has 5', () {
    for (final c in kCategories) {
      final pool = testBank.inCategory(c.id);
      var m = fresh(c.id);
      var rounds = 0;
      Set<String> last = {};
      while (!m.isMastered) {
        final ids = engine.selectLearningRound(categoryQuestions: pool, coveredIds: m.coveredIds, history: {}, conceptErrors: {}, lastRoundIds: last);
        expect(ids, hasLength(5));
        final wasMastered = m.isMastered;
        m = engine.applyRound(m, ids, true);
        if (!m.isMastered) expect(m.status, MasteryStatus.inProgress);
        expect(wasMastered, isFalse);
        last = ids.toSet();
        rounds++;
        expect(rounds, lessThan(200), reason: 'must converge');
      }
      expect(m.covered, pool.length, reason: c.id);
      expect(rounds, (pool.length / 5).ceil(), reason: '${c.id}: uncovered questions are always chosen first');
    }
  });

  test('category is not mastered until the last uncovered question is covered', () {
    final pool = testBank.inCategory('sto');
    final allButOne = pool.take(pool.length - 1).map((q) => q.id).toSet();
    var m = CategoryMastery(categoryId: 'sto', totalQuestions: pool.length, coveredIds: allButOne, roundsPassed: 7, roundsFailed: 0, status: MasteryStatus.inProgress);
    expect(m.isMastered, isFalse);
    final ids = engine.selectLearningRound(categoryQuestions: pool, coveredIds: m.coveredIds, history: {}, conceptErrors: {});
    expect(ids, contains(pool.last.id));
    m = engine.applyRound(m, ids, false);
    expect(m.isMastered, isFalse, reason: 'failed final round does not complete the category');
    m = engine.applyRound(m, ids, true);
    expect(m.isMastered, isTrue);
    expect(engine.isUnlocked('scl', {'ovr': m, 'cpa': m, 'prd': m, 'sto': m}), isTrue);
  });

  test('final partial round supplements with previously missed revision questions', () {
    final pool = testBank.inCategory('sto');
    final remaining = pool.sublist(pool.length - 2).map((q) => q.id).toSet();
    final covered = pool.map((q) => q.id).toSet()..removeAll(remaining);
    final previouslyMissed = pool.first.id;
    final ids = engine.selectLearningRound(
      categoryQuestions: pool,
      coveredIds: covered,
      history: {previouslyMissed: const QuestionHistory(attempts: 2, wrong: 1, lastCorrect: true)},
      conceptErrors: {},
    );
    expect(ids, hasLength(5));
    expect(ids.toSet().containsAll(remaining), isTrue);
    expect(ids, contains(previouslyMissed));
  });

  test('next category to study follows the blueprint order', () {
    expect(engine.nextCategoryToStudy({}), 'ovr');
    final mastered = {for (final c in kCategories.take(3)) c.id: fresh(c.id).copyWithStatus(MasteryStatus.mastered)};
    expect(engine.nextCategoryToStudy(mastered), 'sto');
  });

  group('17. randomization without unnecessary duplication', () {
    test('practice exhausts unseen questions before repeating', () {
      final selector = PracticeSelector(random: Random(7));
      final pool = testBank.inCategory('sto');
      final history = <String, QuestionHistory>{};
      final seen = <String>{};
      var t = DateTime(2026);
      for (var i = 0; i < (pool.length / 5).floor(); i++) {
        final ids = selector.select(mode: PracticeMode.category, bank: testBank.questions, history: history, bookmarkedIds: {}, weakConceptKeys: {}, categoryId: 'sto');
        expect(ids.where(seen.contains), isEmpty, reason: 'round $i repeated a question too early');
        for (final id in ids) {
          seen.add(id);
          t = t.add(const Duration(minutes: 1));
          history[id] = QuestionHistory(attempts: 1, lastAnsweredAt: t, lastCorrect: true);
        }
      }
    });

    test('option order is shuffled per session and is a permutation', () {
      final q = testBank.questions.first;
      final orders = {
        for (var seed = 0; seed < 20; seed++) buildOptionOrder({q.id: q.options.length}, random: Random(seed))[q.id]!.join(),
      };
      expect(orders.length, greaterThan(1));
      for (final o in orders) {
        expect(o.split('').map(int.parse).toSet(), {for (var i = 0; i < q.options.length; i++) i});
      }
    });

    test('practice modes filter correctly', () {
      final selector = PracticeSelector(random: Random(1));
      List<String> pick(PracticeMode m) => selector.select(mode: m, bank: testBank.questions, history: {}, bookmarkedIds: {'SEC-001'}, weakConceptKeys: {}, size: 50);
      expect(pick(PracticeMode.advanced).every((id) => testBank[id].difficulty.level >= 3), isTrue);
      expect(pick(PracticeMode.troubleshooting).every((id) => testBank[id].style == QuestionStyle.troubleshooting), isTrue);
      expect(pick(PracticeMode.bookmarked), ['SEC-001']);
      expect(pick(PracticeMode.incorrect), isEmpty);
    });
  });
}

extension on CategoryMastery {
  CategoryMastery copyWithStatus(MasteryStatus s) => CategoryMastery(
        categoryId: categoryId,
        totalQuestions: totalQuestions,
        coveredIds: coveredIds,
        roundsPassed: roundsPassed,
        roundsFailed: roundsFailed,
        status: s,
      );
}
