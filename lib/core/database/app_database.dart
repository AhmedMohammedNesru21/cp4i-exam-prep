import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../constants/app_constants.dart';

part 'app_database.g.dart';

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get totalQuestions => integer()();
  IntColumn get sortOrder => integer()();
  IntColumn get weight => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('QuestionRow')
@TableIndex(name: 'idx_questions_category', columns: {#categoryId})
@TableIndex(name: 'idx_questions_concept', columns: {#categoryId, #technicalConcept})
class Questions extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(Categories, #id)();
  TextColumn get subcategory => text()();
  // ignore: recursive_getters
  TextColumn get questionType => text().check(questionType.isIn(const ['single', 'multiple']))();
  TextColumn get questionStyle => text()();
  // ignore: recursive_getters
  IntColumn get difficulty => integer().check(difficulty.isBetweenValues(1, 4))();
  TextColumn get component => text()();
  TextColumn get questionText => text().check(questionText.length.isBiggerThanValue(0))();
  TextColumn get optionsJson => text()();
  TextColumn get correctAnswersJson => text()();
  TextColumn get explanation => text()();
  TextColumn get incorrectOptionExplanationsJson => text()();
  TextColumn get scenario => text()();
  TextColumn get examTip => text()();
  TextColumn get technicalConcept => text()();
  TextColumn get documentationReference => text()();
  TextColumn get versionApplicability => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_answers_question', columns: {#questionId})
@TableIndex(name: 'idx_answers_time', columns: {#answeredAt})
class UserAnswers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get questionId => text().references(Questions, #id, onDelete: KeyAction.cascade)();
  TextColumn get selectedAnswersJson => text()();
  BoolColumn get isCorrect => boolean()();
  IntColumn get attemptNumber => integer()();

  /// learning | practice | exam
  TextColumn get source => text()();
  DateTimeColumn get answeredAt => dateTime()();
}

@TableIndex(name: 'idx_rounds_category', columns: {#categoryId, #status})
class LearningRounds extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Null for cross-category practice rounds.
  TextColumn get categoryId => text().nullable().references(Categories, #id)();

  /// learning | practice-* modes
  TextColumn get mode => text()();
  IntColumn get roundNumber => integer()();
  TextColumn get questionIdsJson => text()();
  TextColumn get answersJson => text().withDefault(const Constant('{}'))();
  TextColumn get optionOrderJson => text().withDefault(const Constant('{}'))();
  IntColumn get currentIndex => integer().withDefault(const Constant(0))();
  IntColumn get score => integer().nullable()();

  /// in_progress | passed | failed | completed
  TextColumn get status => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class CategoryProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryId => text().unique().references(Categories, #id)();
  IntColumn get questionsCovered => integer().withDefault(const Constant(0))();
  IntColumn get roundsPassed => integer().withDefault(const Constant(0))();
  IntColumn get roundsFailed => integer().withDefault(const Constant(0))();
  RealColumn get completionPercentage => real().withDefault(const Constant(0))();

  /// not_started | in_progress | retry_required | mastered
  TextColumn get masteryStatus => text().withDefault(const Constant('not_started'))();

  /// Question IDs covered by a passed (5/5) round.
  TextColumn get coveredQuestionIdsJson => text().withDefault(const Constant('[]'))();
}

class MockExams extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime()();
  IntColumn get durationSeconds => integer().nullable()();
  IntColumn get totalQuestions => integer()();
  IntColumn get correctAnswers => integer().nullable()();
  RealColumn get percentage => real().nullable()();

  /// in_progress | pass | fail
  TextColumn get result => text()();
  TextColumn get questionIdsJson => text()();
  TextColumn get answersJson => text().withDefault(const Constant('{}'))();
  TextColumn get flagsJson => text().withDefault(const Constant('[]'))();
  TextColumn get optionOrderJson => text().withDefault(const Constant('{}'))();
  IntColumn get currentIndex => integer().withDefault(const Constant(0))();
  TextColumn get categoryBreakdownJson => text().nullable()();
}

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get questionId => text().unique().references(Questions, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime()();
}

class WeakConcepts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get conceptName => text()();
  TextColumn get categoryId => text().references(Categories, #id)();
  IntColumn get errorCount => integer().withDefault(const Constant(0))();
  IntColumn get correctStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastMissedAt => dateTime().nullable()();

  /// weak | improving | mastered
  TextColumn get masteryStatus => text().withDefault(const Constant('weak'))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {categoryId, conceptName},
      ];
}

class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [
  Categories,
  Questions,
  UserAnswers,
  LearningRounds,
  CategoryProgress,
  MockExams,
  Bookmarks,
  WeakConcepts,
  AppMeta,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: AppConstants.databaseName));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Future schema versions add their steps here, e.g.
          // if (from < 2) await m.addColumn(questions, questions.someNewColumn);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<String?> readMeta(String key) async =>
      (await (select(appMeta)..where((t) => t.key.equals(key))).getSingleOrNull())?.value;

  Future<void> writeMeta(String key, String value) =>
      into(appMeta).insertOnConflictUpdate(AppMetaData(key: key, value: value));
}
