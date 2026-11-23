import 'dart:math';

import 'package:cp4i_exam_prep/core/constants/app_constants.dart';
import 'package:cp4i_exam_prep/core/error/failures.dart';
import 'package:cp4i_exam_prep/core/providers.dart';
import 'package:cp4i_exam_prep/features/mock_exam/domain/exam_engine.dart';
import 'package:cp4i_exam_prep/features/mock_exam/presentation/exam_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final engine = ExamEngine(random: Random(3));

  test('11. a mock exam has 64 unique questions weighted by the blueprint', () {
    final ids = engine.buildExam(testBank.questions);
    expect(ids, hasLength(AppConstants.examQuestionCount));
    expect(ids.toSet(), hasLength(64));
    for (final c in kCategories) {
      expect(ids.where((id) => testBank[id].categoryId == c.id).length, c.examQuestions, reason: c.id);
    }
    expect(kCategories.fold<int>(0, (s, c) => s + c.examQuestions), 64);
  });

  test('consecutive exams avoid recently used questions where possible', () {
    final first = engine.buildExam(testBank.questions).toSet();
    final second = engine.buildExam(testBank.questions, recentExamQuestionIds: first).toSet();
    expect(second.intersection(first), isEmpty);
  });

  test('13. 43/64 passes and 42/64 fails', () {
    final qs = testBank.resolve(engine.buildExam(testBank.questions));
    ExamOutcome withCorrect(int n) {
      final wrong = qs.skip(n).map((q) => q.id).toSet();
      return engine.score(qs, answerKey(qs, wrong: wrong), timeUsed: const Duration(minutes: 60));
    }

    final pass = withCorrect(43);
    expect(pass.correct, 43);
    expect(pass.passed, isTrue);
    expect(pass.percentage, closeTo(67.19, 0.01));
    final fail = withCorrect(42);
    expect(fail.passed, isFalse);
    expect(fail.incorrect, 22);
    expect(fail.weakConcepts, isNotEmpty);
    expect(fail.byCategory.values.fold<int>(0, (s, c) => s + c.total), 64);
  });

  test('unanswered questions count as incorrect', () {
    final qs = testBank.resolve(engine.buildExam(testBank.questions));
    final outcome = engine.score(qs, {}, timeUsed: Duration.zero);
    expect(outcome.correct, 0);
    expect(outcome.unanswered, 64);
    expect(outcome.passed, isFalse);
    expect(outcome.recommendedRevision, hasLength(7));
  });

  test('12. countdown and expiry', () {
    final start = DateTime(2026, 1, 1, 9);
    final deadline = start.add(AppConstants.examDuration);
    expect(engine.remaining(deadline, start), const Duration(minutes: 90));
    expect(engine.remaining(deadline, start.add(const Duration(minutes: 89, seconds: 30))), const Duration(seconds: 30));
    expect(engine.isExpired(deadline, start.add(const Duration(minutes: 89))), isFalse);
    expect(engine.isExpired(deadline, deadline), isTrue);
    expect(engine.remaining(deadline, deadline.add(const Duration(minutes: 5))), Duration.zero);
  });

  test('12. exam controller expires after 90 minutes and caps time used at the deadline', () async {
    final clock = TestClock(DateTime(2026, 3, 1, 10));
    final container = await createContainer(clock: clock);
    addTearDown(container.dispose);
    final controller = container.read(examControllerProvider.notifier);
    await container.read(examControllerProvider.future);
    final session = await controller.start();
    expect(session.questions, hasLength(64));
    expect(controller.remaining, const Duration(minutes: 90));

    await controller.toggleOption(session.questions.first.id, session.questions.first.correctAnswers.first);
    await controller.toggleFlag(session.questions[1].id);

    clock.advance(const Duration(minutes: 45));
    expect(controller.isExpired, isFalse);
    expect(controller.remaining, const Duration(minutes: 45));

    clock.advance(const Duration(minutes: 46));
    expect(controller.isExpired, isTrue);
    await expectLater(controller.toggleOption(session.questions[2].id, 0), throwsA(isA<RuleViolation>()));

    final id = await controller.submit();
    final stored = await container.read(examRepositoryProvider).byId(id);
    expect(stored!.durationSeconds, AppConstants.examDuration.inSeconds, reason: 'time used capped at 90 minutes');
    expect(stored.correct, greaterThanOrEqualTo(1));
    expect(stored.passed, isFalse);
    expect(stored.flags, contains(session.questions[1].id));
    expect(container.read(examControllerProvider).value, isNull);
  });
}
