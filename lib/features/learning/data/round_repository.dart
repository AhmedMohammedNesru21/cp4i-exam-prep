import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Persisted state of a learning or practice round, so the app can resume exactly where it stopped.
class StoredRound {
  const StoredRound({
    required this.id,
    required this.categoryId,
    required this.mode,
    required this.roundNumber,
    required this.questionIds,
    required this.answers,
    required this.optionOrder,
    required this.currentIndex,
    required this.status,
    required this.score,
    required this.startedAt,
    required this.completedAt,
  });

  final int id;
  final String? categoryId;
  final String mode;
  final int roundNumber;
  final List<String> questionIds;
  final Map<String, List<int>> answers;
  final Map<String, List<int>> optionOrder;
  final int currentIndex;
  final String status;
  final int? score;
  final DateTime startedAt;
  final DateTime? completedAt;

  bool get isLearning => mode == 'learning';

  factory StoredRound.fromRow(LearningRound r) => StoredRound(
        id: r.id,
        categoryId: r.categoryId,
        mode: r.mode,
        roundNumber: r.roundNumber,
        questionIds: (jsonDecode(r.questionIdsJson) as List<dynamic>).cast<String>(),
        answers: decodeIntListMap(r.answersJson),
        optionOrder: decodeIntListMap(r.optionOrderJson),
        currentIndex: r.currentIndex,
        status: r.status,
        score: r.score,
        startedAt: r.startedAt,
        completedAt: r.completedAt,
      );
}

Map<String, List<int>> decodeIntListMap(String json) => {
      for (final e in (jsonDecode(json) as Map<String, dynamic>).entries)
        e.key: (e.value as List<dynamic>).cast<int>(),
    };

class RoundRepository {
  RoundRepository(this._db, {DateTime Function()? clock}) : _now = clock ?? DateTime.now;
  final AppDatabase _db;
  final DateTime Function() _now;

  Future<StoredRound> create({
    required String mode,
    required String? categoryId,
    required List<String> questionIds,
    required Map<String, List<int>> optionOrder,
  }) async {
    final countQuery = _db.selectOnly(_db.learningRounds)
      ..addColumns([_db.learningRounds.id.count()])
      ..where(_db.learningRounds.mode.equals(mode) &
          (categoryId == null ? _db.learningRounds.categoryId.isNull() : _db.learningRounds.categoryId.equals(categoryId)));
    final count = await countQuery.map((r) => r.read(_db.learningRounds.id.count()) ?? 0).getSingle();
    final id = await _db.into(_db.learningRounds).insert(LearningRoundsCompanion.insert(
          categoryId: Value(categoryId),
          mode: mode,
          roundNumber: count + 1,
          questionIdsJson: jsonEncode(questionIds),
          optionOrderJson: Value(jsonEncode(optionOrder)),
          status: 'in_progress',
          startedAt: _now(),
        ));
    return (await byId(id))!;
  }

  Future<StoredRound?> byId(int id) async {
    final row = await (_db.select(_db.learningRounds)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : StoredRound.fromRow(row);
  }

  Future<void> saveProgress(int id, Map<String, List<int>> answers, int currentIndex) =>
      (_db.update(_db.learningRounds)..where((t) => t.id.equals(id))).write(LearningRoundsCompanion(
        answersJson: Value(jsonEncode(answers)),
        currentIndex: Value(currentIndex),
      ));

  Future<void> complete(int id, {required int score, required String status, required Map<String, List<int>> answers}) =>
      (_db.update(_db.learningRounds)..where((t) => t.id.equals(id))).write(LearningRoundsCompanion(
        answersJson: Value(jsonEncode(answers)),
        score: Value(score),
        status: Value(status),
        completedAt: Value(_now()),
      ));

  /// The round to resume after an app restart, if any.
  Future<StoredRound?> active() async {
    final row = await (_db.select(_db.learningRounds)
          ..where((t) => t.status.equals('in_progress'))
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : StoredRound.fromRow(row);
  }

  /// Abandon any in-progress rounds (only one round may be active at a time).
  Future<void> abandonActive() => (_db.update(_db.learningRounds)..where((t) => t.status.equals('in_progress')))
      .write(const LearningRoundsCompanion(status: Value('abandoned')));

  Future<StoredRound?> lastCompletedLearningRound(String categoryId) async {
    final row = await (_db.select(_db.learningRounds)
          ..where((t) =>
              t.categoryId.equals(categoryId) & t.mode.equals('learning') & t.status.isIn(['passed', 'failed']))
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : StoredRound.fromRow(row);
  }

  Future<List<StoredRound>> history({int limit = 200, String? categoryId}) async {
    final q = _db.select(_db.learningRounds)
      ..where((t) => t.status.isIn(['passed', 'failed', 'completed']))
      ..orderBy([(t) => OrderingTerm.desc(t.completedAt)])
      ..limit(limit);
    if (categoryId != null) q.where((t) => t.categoryId.equals(categoryId));
    return (await q.get()).map(StoredRound.fromRow).toList();
  }
}
