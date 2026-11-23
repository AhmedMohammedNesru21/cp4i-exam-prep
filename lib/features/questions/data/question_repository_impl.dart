import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/error/failures.dart';
import '../domain/question.dart';
import '../domain/question_bank.dart';
import 'question_bank_parser.dart';

typedef AssetLoader = Future<String> Function(String path);

class QuestionRepositoryImpl implements QuestionRepository {
  QuestionRepositoryImpl(this._db, this._loadAsset);

  final AppDatabase _db;
  final AssetLoader _loadAsset;
  QuestionBank? _cache;

  static const _signatureKey = 'bank_signature';

  Future<List<Question>> _parseAssets() async {
    final index = jsonDecode(await _loadAsset(AppConstants.bankIndexAsset)) as Map<String, dynamic>;
    final parser = QuestionBankParser();
    final questions = <Question>[];
    for (final file in (index['files'] as List<dynamic>).cast<String>()) {
      questions.addAll(parser.parseFile(await _loadAsset('assets/questions/$file')));
    }
    final ids = questions.map((q) => q.id).toSet();
    if (ids.length != questions.length) throw const DataFailure('Duplicate question IDs in bank');
    return questions;
  }

  @override
  Future<void> seedIfNeeded() async {
    final index = jsonDecode(await _loadAsset(AppConstants.bankIndexAsset)) as Map<String, dynamic>;
    final current = await _db.readMeta(_signatureKey);
    final questions = await _parseAssets();
    final signature = 'v${index['bankVersion']}:${questions.length}';
    if (current == signature) return;

    await _db.transaction(() async {
      await _db.batch((b) {
        b.insertAllOnConflictUpdate(_db.categories, [
          for (final c in kCategories)
            CategoriesCompanion.insert(
              id: c.id,
              name: c.name,
              description: c.description,
              totalQuestions: questions.where((q) => q.categoryId == c.id).length,
              sortOrder: c.sortOrder,
              weight: c.weight,
            ),
        ]);
        b.insertAllOnConflictUpdate(_db.questions, [for (final q in questions) _toCompanion(q)]);
        b.insertAll(
          _db.categoryProgress,
          [for (final c in kCategories) CategoryProgressCompanion.insert(categoryId: c.id)],
          mode: InsertMode.insertOrIgnore,
        );
      });
      await _db.writeMeta(_signatureKey, signature);
    });
    _cache = null;
  }

  @override
  Future<QuestionBank> loadBank() async {
    final cached = _cache;
    if (cached != null) return cached;
    final rows = await (_db.select(_db.questions)..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
    if (rows.isEmpty) throw const DataFailure('Question bank is empty. Seeding has not run.');
    return _cache = QuestionBank(rows.map(_fromRow).toList());
  }

  QuestionsCompanion _toCompanion(Question q) => QuestionsCompanion.insert(
        id: q.id,
        categoryId: q.categoryId,
        subcategory: q.subcategory,
        questionType: q.type.name,
        questionStyle: q.style.name,
        difficulty: q.difficulty.level,
        component: q.component,
        questionText: q.text,
        optionsJson: jsonEncode(q.options),
        correctAnswersJson: jsonEncode(q.correctAnswers),
        explanation: q.explanation,
        incorrectOptionExplanationsJson: jsonEncode(q.optionRationales),
        scenario: q.scenario,
        examTip: q.examTip,
        technicalConcept: q.technicalConcept,
        documentationReference: q.documentationReference,
        versionApplicability: q.versionApplicability,
      );

  Question _fromRow(QuestionRow r) => Question(
        id: r.id,
        categoryId: r.categoryId,
        subcategory: r.subcategory,
        style: QuestionStyle.values.byName(r.questionStyle),
        difficulty: Difficulty.fromLevel(r.difficulty),
        component: r.component,
        text: r.questionText,
        options: (jsonDecode(r.optionsJson) as List<dynamic>).cast<String>(),
        correctAnswers: (jsonDecode(r.correctAnswersJson) as List<dynamic>).cast<int>(),
        explanation: r.explanation,
        optionRationales: (jsonDecode(r.incorrectOptionExplanationsJson) as List<dynamic>).cast<String>(),
        scenario: r.scenario,
        examTip: r.examTip,
        documentationReference: r.documentationReference,
        versionApplicability: r.versionApplicability,
      );
}
