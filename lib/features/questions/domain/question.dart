/// Immutable question entity used by all engines and screens.
library;

enum QuestionType { single, multiple }

enum QuestionStyle {
  fundamental('Fundamental'),
  scenario('Scenario / Architecture'),
  troubleshooting('Troubleshooting'),
  design('Advanced design');

  const QuestionStyle(this.label);
  final String label;

  static QuestionStyle fromCode(String code) => switch (code) {
        'F' => QuestionStyle.fundamental,
        'S' => QuestionStyle.scenario,
        'T' => QuestionStyle.troubleshooting,
        'D' => QuestionStyle.design,
        _ => throw FormatException('Unknown question style code: $code'),
      };
}

enum Difficulty {
  beginner('Beginner'),
  intermediate('Intermediate'),
  advanced('Advanced'),
  expert('Expert');

  const Difficulty(this.label);
  final String label;

  /// 1-based level as stored in the bank.
  int get level => index + 1;

  static Difficulty fromLevel(int level) {
    if (level < 1 || level > 4) throw FormatException('Unknown difficulty level: $level');
    return Difficulty.values[level - 1];
  }
}

class Question {
  const Question({
    required this.id,
    required this.categoryId,
    required this.subcategory,
    required this.style,
    required this.difficulty,
    required this.component,
    required this.text,
    required this.options,
    required this.correctAnswers,
    required this.explanation,
    required this.optionRationales,
    required this.scenario,
    required this.examTip,
    required this.documentationReference,
    required this.versionApplicability,
  });

  final String id;
  final String categoryId;
  final String subcategory;
  final QuestionStyle style;
  final Difficulty difficulty;

  /// IBM / Red Hat component the question is about.
  final String component;
  final String text;
  final List<String> options;

  /// Sorted indexes into [options].
  final List<int> correctAnswers;
  final String explanation;

  /// One rationale per option (why it is right or wrong).
  final List<String> optionRationales;

  /// Real enterprise implementation scenario / architecture implication.
  final String scenario;
  final String examTip;
  final String documentationReference;
  final String versionApplicability;

  QuestionType get type => correctAnswers.length > 1 ? QuestionType.multiple : QuestionType.single;
  bool get isMultiple => type == QuestionType.multiple;
  int get requiredSelections => correctAnswers.length;

  /// The technical concept tracked by the weak-area engine.
  String get technicalConcept => subcategory;

  /// All-or-nothing scoring: every correct option and nothing else.
  bool isAnsweredCorrectly(Iterable<int> selected) {
    final s = selected.toSet();
    return s.length == correctAnswers.length && correctAnswers.every(s.contains);
  }
}
