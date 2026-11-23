import 'dart:convert';
import 'dart:io';

import 'package:cp4i_exam_prep/core/database/app_database.dart';
import 'package:cp4i_exam_prep/core/providers.dart';
import 'package:cp4i_exam_prep/features/questions/data/question_bank_parser.dart';
import 'package:cp4i_exam_prep/features/questions/domain/question.dart';
import 'package:cp4i_exam_prep/features/questions/domain/question_bank.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reads bundled assets straight from disk (tests run from the project root).
Future<String> diskAssetLoader(String path) => File(path).readAsString();

List<Question> loadBankFromDisk() {
  final index = jsonDecode(File('assets/questions/index.json').readAsStringSync()) as Map<String, dynamic>;
  final parser = QuestionBankParser();
  return [
    for (final f in (index['files'] as List<dynamic>).cast<String>())
      ...parser.parseFile(File('assets/questions/$f').readAsStringSync()),
  ];
}

QuestionBank? _bank;
QuestionBank get testBank => _bank ??= QuestionBank(loadBankFromDisk());

/// Mutable clock for timer tests.
class TestClock {
  TestClock(this.now);
  DateTime now;
  DateTime call() => now;
  void advance(Duration d) => now = now.add(d);
}

Future<ProviderContainer> createContainer({
  AppDatabase? db,
  TestClock? clock,
  Map<String, Object> prefs = const {},
}) async {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  final database = db ?? AppDatabase(NativeDatabase.memory());
  final container = ProviderContainer(overrides: [
    databaseProvider.overrideWithValue(database),
    sharedPreferencesProvider.overrideWithValue(sp),
    assetLoaderProvider.overrideWithValue(diskAssetLoader),
    if (clock != null) clockProvider.overrideWithValue(clock.call),
  ]);
  await container.read(questionBankProvider.future);
  return container;
}

/// Answers every question in the active learning round correctly (or not).
Map<String, List<int>> answerKey(List<Question> questions, {Set<String> wrong = const {}}) => {
      for (final q in questions)
        q.id: wrong.contains(q.id)
            ? [for (var i = 0; i < q.options.length; i++) if (!q.correctAnswers.contains(i)) i].take(q.requiredSelections).toList()
            : List.of(q.correctAnswers),
    };
