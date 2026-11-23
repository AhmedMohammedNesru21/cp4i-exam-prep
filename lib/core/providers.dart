import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/bookmarks/data/bookmark_repository.dart';
import '../features/learning/data/progress_repository.dart';
import '../features/learning/data/round_repository.dart';
import '../features/learning/domain/mastery_engine.dart';
import '../features/mock_exam/data/exam_repository.dart';
import '../features/mock_exam/domain/exam_engine.dart';
import '../features/practice/domain/practice_selector.dart';
import '../features/questions/data/question_repository_impl.dart';
import '../features/questions/domain/question_bank.dart';
import 'database/app_database.dart';

/// Infrastructure -------------------------------------------------------------

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Must be overridden in main() / tests with an initialized instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final assetLoaderProvider = Provider<AssetLoader>((ref) => rootBundle.loadString);

/// Clock injection keeps timers and history testable.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// Repositories -----------------------------------------------------------------

final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => QuestionRepositoryImpl(ref.watch(databaseProvider), ref.watch(assetLoaderProvider)),
);

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => ProgressRepository(ref.watch(databaseProvider), clock: ref.watch(clockProvider)),
);

final roundRepositoryProvider = Provider<RoundRepository>(
  (ref) => RoundRepository(ref.watch(databaseProvider), clock: ref.watch(clockProvider)),
);

final examRepositoryProvider = Provider<ExamRepository>((ref) => ExamRepository(ref.watch(databaseProvider)));

final bookmarkRepositoryProvider = Provider<BookmarkRepository>(
  (ref) => BookmarkRepository(ref.watch(databaseProvider), clock: ref.watch(clockProvider)),
);

/// Engines ----------------------------------------------------------------------

final masteryEngineProvider = Provider<MasteryEngine>((ref) => MasteryEngine());
final practiceSelectorProvider = Provider<PracticeSelector>((ref) => PracticeSelector());
final examEngineProvider = Provider<ExamEngine>((ref) => ExamEngine());

/// Data -------------------------------------------------------------------------

/// Seeds the bundled bank on first launch (or when it changes) and loads it into memory.
final questionBankProvider = FutureProvider<QuestionBank>((ref) async {
  final repo = ref.watch(questionRepositoryProvider);
  await repo.seedIfNeeded();
  return repo.loadBank();
});
