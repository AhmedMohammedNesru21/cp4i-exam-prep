import 'dart:io';

import 'package:cp4i_exam_prep/core/database/app_database.dart';
import 'package:cp4i_exam_prep/core/error/failures.dart';
import 'package:cp4i_exam_prep/core/providers.dart';
import 'package:cp4i_exam_prep/features/learning/domain/learning_models.dart';
import 'package:cp4i_exam_prep/features/learning/presentation/progress_providers.dart';
import 'package:cp4i_exam_prep/features/learning/presentation/session_controller.dart';
import 'package:cp4i_exam_prep/features/practice/domain/practice_selector.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

/// Blocks every network call: the app must work fully offline.
class _NoNetwork extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => throw StateError('Network access attempted while offline');
}

void main() {
  late Directory dir;
  setUp(() => dir = Directory.systemTemp.createTempSync('cp4i_test'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('14. progress and the in-progress round survive an application restart', () async {
    final file = File('${dir.path}/app.sqlite');

    // --- first launch ---
    var container = await createContainer(db: AppDatabase(NativeDatabase(file)));
    var controller = container.read(sessionControllerProvider.notifier);
    await container.read(sessionControllerProvider.future);

    // Pass one round in ovr.
    await controller.startLearning('ovr');
    var s = container.read(sessionControllerProvider).value!;
    for (final q in s.questions) {
      for (final o in q.correctAnswers) {
        await controller.toggleOption(q.id, o);
      }
    }
    final passed = await controller.submit();
    expect(passed.passed, isTrue);

    // Start a second round and answer two questions, leave on question 3.
    await controller.startLearning('ovr');
    s = container.read(sessionControllerProvider).value!;
    final roundId = s.round.id;
    await controller.toggleOption(s.questions[0].id, s.questions[0].correctAnswers.first);
    await controller.toggleOption(s.questions[1].id, s.questions[1].correctAnswers.first);
    await controller.goTo(2);
    await container.read(bookmarkRepositoryProvider).toggle(s.questions[0].id);
    final expectedAnswers = container.read(sessionControllerProvider).value!.answers;
    container.dispose(); // closes the database

    // --- second launch on the same database file ---
    container = await createContainer(db: AppDatabase(NativeDatabase(file)));
    addTearDown(container.dispose);
    final resumed = await container.read(sessionControllerProvider.future);
    expect(resumed, isNotNull);
    expect(resumed!.round.id, roundId);
    expect(resumed.index, 2);
    expect(resumed.answers, expectedAnswers);
    expect(resumed.round.optionOrder, isNotEmpty);

    final mastery = await container.read(masteryMapProvider.future);
    expect(mastery['ovr']!.covered, 5);
    expect(mastery['ovr']!.roundsPassed, 1);
    expect(mastery['ovr']!.status, MasteryStatus.inProgress);
    expect(await container.read(bookmarkRepositoryProvider).ids(), contains(s.questions[0].id));
    final dash = await container.read(dashboardProvider.future);
    expect(dash.totals.answers, 5);
    expect(dash.totals.correct, 5);
    expect(dash.activeRound?.id, roundId);
  });

  test('failed rounds record weak concepts and keep the next category locked', () async {
    final container = await createContainer();
    addTearDown(container.dispose);
    final controller = container.read(sessionControllerProvider.notifier);
    await container.read(sessionControllerProvider.future);

    // cpa is locked until ovr is mastered.
    await expectLater(controller.startLearning('cpa'), throwsA(isA<RuleViolation>()));

    await controller.startLearning('ovr');
    final s = container.read(sessionControllerProvider).value!;
    final key = answerKey(s.questions, wrong: {s.questions.first.id});
    for (final e in key.entries) {
      for (final o in e.value) {
        await controller.toggleOption(e.key, o);
      }
    }
    final result = await controller.submit();
    expect(result.passed, isFalse);

    final mastery = await container.read(masteryMapProvider.future);
    expect(mastery['ovr']!.status, MasteryStatus.retryRequired);
    expect(mastery['ovr']!.covered, 0);
    final weak = await container.read(weakConceptsProvider.future);
    expect(weak.map((w) => w.conceptName), contains(s.questions.first.technicalConcept));

    final review = await container.read(roundReviewProvider(result.roundId).future);
    expect(review.score, 4);
    expect(review.passed, isFalse);

    // The retry round is a new set that includes the missed question.
    await controller.startLearning('ovr');
    final retry = container.read(sessionControllerProvider).value!;
    expect(retry.round.questionIds.toSet(), isNot(equals(s.round.questionIds.toSet())));
    expect(retry.round.questionIds, contains(s.questions.first.id));
  });

  test('15. the full learning, practice and exam flow works with no network access', () async {
    await HttpOverrides.runZoned(() async {
      final container = await createContainer();
      addTearDown(container.dispose);
      final bank = await container.read(questionBankProvider.future);
      expect(bank.length, greaterThanOrEqualTo(600));
      final controller = container.read(sessionControllerProvider.notifier);
      await container.read(sessionControllerProvider.future);
      expect(await controller.startPractice(PracticeMode.random), 5);
      await controller.submit();
      expect(await controller.startPractice(PracticeMode.incorrect), greaterThan(0), reason: 'unanswered practice counts as incorrect');
    }, createHttpClient: (_) => _NoNetwork().createHttpClient(null));
  });

  test('re-seeding the bank is idempotent and keeps user progress', () async {
    final container = await createContainer();
    addTearDown(container.dispose);
    final controller = container.read(sessionControllerProvider.notifier);
    await container.read(sessionControllerProvider.future);
    await controller.startPractice(PracticeMode.random);
    await controller.submit();
    final db = container.read(databaseProvider);
    await db.writeMeta('bank_signature', 'stale');
    await container.read(questionRepositoryProvider).seedIfNeeded();
    final totals = await container.read(progressRepositoryProvider).totals();
    expect(totals.answers, 5);
    expect((await db.select(db.questions).get()).length, greaterThanOrEqualTo(600));
  });
}
