import 'package:cp4i_exam_prep/app.dart';
import 'package:cp4i_exam_prep/core/database/app_database.dart';
import 'package:cp4i_exam_prep/core/providers.dart';
import 'package:cp4i_exam_prep/core/router/app_router.dart';
import 'package:cp4i_exam_prep/features/learning/presentation/session_controller.dart';
import 'package:cp4i_exam_prep/features/mock_exam/presentation/exam_controller.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

/// Pumps the real app (router, theme, providers) on an in-memory database.
Future<ProviderContainer> pumpApp(WidgetTester tester, {Size size = const Size(390, 844), bool onboarded = true}) async {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  tester.view.physicalSize = size * tester.view.devicePixelRatio;
  addTearDown(tester.view.resetPhysicalSize);
  SharedPreferences.setMockInitialValues({'onboarding_complete': onboarded});
  final prefs = await SharedPreferences.getInstance();
  late ProviderContainer container;
  await tester.runAsync(() async {
    container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
      sharedPreferencesProvider.overrideWithValue(prefs),
      assetLoaderProvider.overrideWithValue(diskAssetLoader),
    ]);
    await container.read(questionBankProvider.future);
  });
  await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const Cp4iExamPrepApp()));
  await settle(tester);
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
    container.dispose();
  });
  return container;
}

/// Pumps frames while letting real async (database) work complete.
Future<void> settle(WidgetTester tester, {int frames = 12}) async {
  for (var i = 0; i < frames; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 5)));
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Future<void> tapKey(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(Key(key)));
  await tester.tap(find.byKey(Key(key)));
  await settle(tester);
}

/// Taps the displayed option letters matching the given original indexes.
Future<void> answer(WidgetTester tester, ProviderContainer c, {required bool correctly}) async {
  final s = c.read(sessionControllerProvider).value!;
  final q = s.current;
  final order = s.orderFor(q);
  final targets = correctly
      ? q.correctAnswers
      : [for (var i = 0; i < q.options.length; i++) if (!q.correctAnswers.contains(i)) i].take(q.requiredSelections).toList();
  for (final original in targets) {
    await tapKey(tester, 'option-${String.fromCharCode(65 + order.indexOf(original))}');
  }
}

/// Tall portrait viewport so whole question screens are laid out for interaction tests.
const tall = Size(430, 2000);

void main() {
  testWidgets('onboarding is shown on first launch and leads to the dashboard', (tester) async {
    await pumpApp(tester, onboarded: false);
    expect(find.text('Structured mastery'), findsOneWidget);
    for (var i = 0; i < 4; i++) {
      await tapKey(tester, 'onboarding-next');
    }
    await tester.enterText(find.byKey(const Key('name-field')), 'Ahmed');
    await tapKey(tester, 'onboarding-next');
    expect(find.text('Welcome back, Ahmed'), findsOneWidget);
    expect(find.byKey(const Key('overall-progress')), findsOneWidget);
  });

  testWidgets('dashboard renders at phone and tablet sizes without overflow', (tester) async {
    for (final size in [const Size(360, 690), const Size(412, 915), const Size(1024, 1366)]) {
      await pumpApp(tester, size: size);
      expect(find.text('Overall progress: 0%'), findsOneWidget);
      expect(find.byKey(const Key('continue-learning')), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('18. navigating between questions preserves selected answers', (tester) async {
    final c = await pumpApp(tester, size: tall);
    await tester.runAsync(() => c.read(sessionControllerProvider.notifier).startLearning('ovr'));
    c.read(routerProvider).push('/session');
    await settle(tester);
    expect(find.text('Question 1/5'), findsOneWidget);

    await answer(tester, c, correctly: true);
    final firstId = c.read(sessionControllerProvider).value!.questions.first.id;
    final firstSelection = List.of(c.read(sessionControllerProvider).value!.answers[firstId]!);
    await tapKey(tester, 'next');
    expect(find.text('Question 2/5'), findsOneWidget);
    await tapKey(tester, 'prev');
    expect(find.text('Question 1/5'), findsOneWidget);
    expect(c.read(sessionControllerProvider).value!.answers[firstId], firstSelection);
    final selectedIcons = find.byIcon(c.read(sessionControllerProvider).value!.current.isMultiple ? Icons.check_box : Icons.radio_button_checked);
    expect(selectedIcons, findsNWidgets(firstSelection.length));
  });

  testWidgets('a perfect round shows PASS; 4/5 shows NOT PASSED with Retry', (tester) async {
    final c = await pumpApp(tester, size: tall);
    final router = c.read(routerProvider);

    Future<void> playRound({required int wrongAt}) async {
      await tester.runAsync(() => c.read(sessionControllerProvider.notifier).startLearning('ovr'));
      router.push('/session');
      await settle(tester);
      for (var i = 0; i < 5; i++) {
        await answer(tester, c, correctly: i != wrongAt);
        await tapKey(tester, i < 4 ? 'next' : 'submit');
      }
    }

    await playRound(wrongAt: -1);
    expect(find.text('5/5'), findsOneWidget);
    expect(find.text('EXCELLENT! 5/5 – MASTERED'), findsOneWidget);
    expect(find.byKey(const Key('next-round')), findsOneWidget);

    router.go('/learn');
    await settle(tester);
    await playRound(wrongAt: 2);
    expect(find.text('4/5'), findsOneWidget);
    expect(find.text('NOT PASSED – RETRY REQUIRED'), findsOneWidget);
    expect(find.byKey(const Key('retry')), findsOneWidget);

    await tapKey(tester, 'review-explanations');
    expect(find.text('Detailed Explanations'), findsOneWidget);
    expect(find.text('Why each option is right or wrong'), findsWidgets);
    expect(find.text('Exam tip and common mistakes'), findsWidgets);
  });

  testWidgets('submit is disabled until all five learning questions are answered', (tester) async {
    final c = await pumpApp(tester, size: tall);
    await tester.runAsync(() => c.read(sessionControllerProvider.notifier).startLearning('ovr'));
    c.read(routerProvider).push('/session');
    await settle(tester);
    for (var i = 0; i < 4; i++) {
      await tapKey(tester, 'next');
    }
    final submit = tester.widget<ButtonStyleButton>(find.ancestor(of: find.text('Submit'), matching: find.byWidgetPredicate((w) => w is ButtonStyleButton)));
    expect(submit.onPressed, isNull);
  });

  testWidgets('mock exam shows 64 questions, a running countdown, and supports mark for review', (tester) async {
    final c = await pumpApp(tester, size: tall);
    c.read(routerProvider).go('/exam');
    await settle(tester);
    await tapKey(tester, 'start-exam');
    expect(find.text('Question 1/64'), findsOneWidget);
    expect(find.byKey(const Key('exam-timer')), findsOneWidget);
    expect(find.textContaining(RegExp(r'^(1:30:00|1:29:5\d)$')), findsOneWidget);
    await tapKey(tester, 'flag');
    expect(find.text('Marked'), findsOneWidget);
    await tapKey(tester, 'exam-next');
    expect(find.text('Question 2/64'), findsOneWidget);
    expect(c.read(examControllerProvider).value!.flags, hasLength(1));
  });
}
