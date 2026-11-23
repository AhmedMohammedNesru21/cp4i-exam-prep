/// Typed failures surfaced to the presentation layer.
sealed class AppFailure implements Exception {
  const AppFailure(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Corrupt or missing local data (question bank, database).
class DataFailure extends AppFailure {
  const DataFailure(super.message);
}

/// A user action that is not allowed by the learning rules (for example a locked category).
class RuleViolation extends AppFailure {
  const RuleViolation(super.message);
}
