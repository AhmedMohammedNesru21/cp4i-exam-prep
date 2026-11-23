import 'question.dart';

/// In-memory, read-only view of the complete question bank.
class QuestionBank {
  QuestionBank(List<Question> questions)
      : questions = List.unmodifiable(questions),
        _byId = {for (final q in questions) q.id: q};

  final List<Question> questions;
  final Map<String, Question> _byId;

  int get length => questions.length;
  Question? byId(String id) => _byId[id];
  Question operator [](String id) => _byId[id] ?? (throw StateError('Unknown question $id'));

  List<Question> inCategory(String categoryId) => questions.where((q) => q.categoryId == categoryId).toList();

  List<Question> resolve(Iterable<String> ids) => [for (final id in ids) this[id]];
}

/// Repository contract for the question bank (domain layer).
abstract interface class QuestionRepository {
  /// Imports/updates the bundled bank into local storage when needed.
  Future<void> seedIfNeeded();

  Future<QuestionBank> loadBank();
}
