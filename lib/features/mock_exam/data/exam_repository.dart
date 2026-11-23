import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../learning/data/round_repository.dart' show decodeIntListMap;
import '../domain/exam_engine.dart';

class StoredExam {
  const StoredExam({
    required this.id,
    required this.startedAt,
    required this.deadline,
    required this.completedAt,
    required this.questionIds,
    required this.answers,
    required this.flags,
    required this.optionOrder,
    required this.currentIndex,
    required this.result,
    required this.correct,
    required this.percentage,
    required this.durationSeconds,
    required this.byCategory,
  });

  final int id;
  final DateTime startedAt;
  final DateTime deadline;
  final DateTime? completedAt;
  final List<String> questionIds;
  final Map<String, List<int>> answers;
  final Set<String> flags;
  final Map<String, List<int>> optionOrder;
  final int currentIndex;

  /// in_progress | pass | fail
  final String result;
  final int? correct;
  final double? percentage;
  final int? durationSeconds;
  final Map<String, CategoryScore> byCategory;

  bool get inProgress => result == 'in_progress';
  bool get passed => result == 'pass';

  factory StoredExam.fromRow(MockExam r) => StoredExam(
        id: r.id,
        startedAt: r.startedAt,
        deadline: r.deadline,
        completedAt: r.completedAt,
        questionIds: (jsonDecode(r.questionIdsJson) as List<dynamic>).cast<String>(),
        answers: decodeIntListMap(r.answersJson),
        flags: (jsonDecode(r.flagsJson) as List<dynamic>).cast<String>().toSet(),
        optionOrder: decodeIntListMap(r.optionOrderJson),
        currentIndex: r.currentIndex,
        result: r.result,
        correct: r.correctAnswers,
        percentage: r.percentage,
        durationSeconds: r.durationSeconds,
        byCategory: r.categoryBreakdownJson == null
            ? const {}
            : {
                for (final e in (jsonDecode(r.categoryBreakdownJson!) as Map<String, dynamic>).entries)
                  e.key: CategoryScore.fromJson(e.value as Map<String, dynamic>),
              },
      );
}

class ExamRepository {
  ExamRepository(this._db);
  final AppDatabase _db;

  Future<StoredExam> create({
    required List<String> questionIds,
    required Map<String, List<int>> optionOrder,
    required DateTime startedAt,
  }) async {
    final id = await _db.into(_db.mockExams).insert(MockExamsCompanion.insert(
          startedAt: startedAt,
          deadline: startedAt.add(AppConstants.examDuration),
          totalQuestions: questionIds.length,
          result: 'in_progress',
          questionIdsJson: jsonEncode(questionIds),
          optionOrderJson: Value(jsonEncode(optionOrder)),
        ));
    return (await byId(id))!;
  }

  Future<StoredExam?> byId(int id) async {
    final row = await (_db.select(_db.mockExams)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : StoredExam.fromRow(row);
  }

  Future<StoredExam?> active() async {
    final row = await (_db.select(_db.mockExams)
          ..where((t) => t.result.equals('in_progress'))
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : StoredExam.fromRow(row);
  }

  Future<void> saveProgress(int id, {required Map<String, List<int>> answers, required Set<String> flags, required int currentIndex}) =>
      (_db.update(_db.mockExams)..where((t) => t.id.equals(id))).write(MockExamsCompanion(
        answersJson: Value(jsonEncode(answers)),
        flagsJson: Value(jsonEncode(flags.toList())),
        currentIndex: Value(currentIndex),
      ));

  Future<void> complete(int id, {required ExamOutcome outcome, required Map<String, List<int>> answers, required DateTime completedAt}) =>
      (_db.update(_db.mockExams)..where((t) => t.id.equals(id))).write(MockExamsCompanion(
        answersJson: Value(jsonEncode(answers)),
        completedAt: Value(completedAt),
        durationSeconds: Value(outcome.timeUsed.inSeconds),
        correctAnswers: Value(outcome.correct),
        percentage: Value(outcome.percentage),
        result: Value(outcome.passed ? 'pass' : 'fail'),
        categoryBreakdownJson: Value(jsonEncode({for (final e in outcome.byCategory.entries) e.key: e.value.toJson()})),
      ));

  Future<List<StoredExam>> completed({int limit = 100}) async {
    final rows = await (_db.select(_db.mockExams)
          ..where((t) => t.result.isIn(['pass', 'fail']))
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(limit))
        .get();
    return rows.map(StoredExam.fromRow).toList();
  }

  /// Question IDs used in the most recent [count] exams (to vary consecutive exams).
  Future<Set<String>> recentQuestionIds({int count = 3}) async =>
      {for (final e in await completed(limit: count)) ...e.questionIds};
}
