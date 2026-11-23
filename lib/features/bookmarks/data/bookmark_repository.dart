import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class BookmarkRepository {
  BookmarkRepository(this._db, {DateTime Function()? clock}) : _now = clock ?? DateTime.now;
  final AppDatabase _db;
  final DateTime Function() _now;

  Future<Set<String>> ids() async {
    final rows = await (_db.select(_db.bookmarks)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return {for (final r in rows) r.questionId};
  }

  Future<List<String>> orderedIds() async {
    final rows = await (_db.select(_db.bookmarks)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return [for (final r in rows) r.questionId];
  }

  /// Returns true when the question is bookmarked after the toggle.
  Future<bool> toggle(String questionId) async {
    final deleted = await (_db.delete(_db.bookmarks)..where((t) => t.questionId.equals(questionId))).go();
    if (deleted > 0) return false;
    await _db.into(_db.bookmarks).insert(BookmarksCompanion.insert(questionId: questionId, createdAt: _now()));
    return true;
  }
}
