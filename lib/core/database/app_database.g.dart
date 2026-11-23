// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    totalQuestions,
    sortOrder,
    weight,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String description;
  final int totalQuestions;
  final int sortOrder;
  final int weight;
  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.totalQuestions,
    required this.sortOrder,
    required this.weight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['sort_order'] = Variable<int>(sortOrder);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      totalQuestions: Value(totalQuestions),
      sortOrder: Value(sortOrder),
      weight: Value(weight),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'weight': serializer.toJson<int>(weight),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? description,
    int? totalQuestions,
    int? sortOrder,
    int? weight,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    sortOrder: sortOrder ?? this.sortOrder,
    weight: weight ?? this.weight,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, totalQuestions, sortOrder, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.totalQuestions == this.totalQuestions &&
          other.sortOrder == this.sortOrder &&
          other.weight == this.weight);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> totalQuestions;
  final Value<int> sortOrder;
  final Value<int> weight;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String description,
    required int totalQuestions,
    required int sortOrder,
    required int weight,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       totalQuestions = Value(totalQuestions),
       sortOrder = Value(sortOrder),
       weight = Value(weight);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? totalQuestions,
    Expression<int>? sortOrder,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? totalQuestions,
    Value<int>? sortOrder,
    Value<int>? weight,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      sortOrder: sortOrder ?? this.sortOrder,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, QuestionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _subcategoryMeta = const VerificationMeta(
    'subcategory',
  );
  @override
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
    'subcategory',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionTypeMeta = const VerificationMeta(
    'questionType',
  );
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
    'question_type',
    aliasedName,
    false,
    check: () => questionType.isIn(const ['single', 'multiple']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionStyleMeta = const VerificationMeta(
    'questionStyle',
  );
  @override
  late final GeneratedColumn<String> questionStyle = GeneratedColumn<String>(
    'question_style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    check: () => ComparableExpr(difficulty).isBetweenValues(1, 4),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _componentMeta = const VerificationMeta(
    'component',
  );
  @override
  late final GeneratedColumn<String> component = GeneratedColumn<String>(
    'component',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionTextMeta = const VerificationMeta(
    'questionText',
  );
  @override
  late final GeneratedColumn<String> questionText = GeneratedColumn<String>(
    'question_text',
    aliasedName,
    false,
    check: () => ComparableExpr(questionText.length).isBiggerThanValue(0),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionsJsonMeta = const VerificationMeta(
    'optionsJson',
  );
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
    'options_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersJsonMeta =
      const VerificationMeta('correctAnswersJson');
  @override
  late final GeneratedColumn<String> correctAnswersJson =
      GeneratedColumn<String>(
        'correct_answers_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incorrectOptionExplanationsJsonMeta =
      const VerificationMeta('incorrectOptionExplanationsJson');
  @override
  late final GeneratedColumn<String> incorrectOptionExplanationsJson =
      GeneratedColumn<String>(
        'incorrect_option_explanations_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _scenarioMeta = const VerificationMeta(
    'scenario',
  );
  @override
  late final GeneratedColumn<String> scenario = GeneratedColumn<String>(
    'scenario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examTipMeta = const VerificationMeta(
    'examTip',
  );
  @override
  late final GeneratedColumn<String> examTip = GeneratedColumn<String>(
    'exam_tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _technicalConceptMeta = const VerificationMeta(
    'technicalConcept',
  );
  @override
  late final GeneratedColumn<String> technicalConcept = GeneratedColumn<String>(
    'technical_concept',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentationReferenceMeta =
      const VerificationMeta('documentationReference');
  @override
  late final GeneratedColumn<String> documentationReference =
      GeneratedColumn<String>(
        'documentation_reference',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _versionApplicabilityMeta =
      const VerificationMeta('versionApplicability');
  @override
  late final GeneratedColumn<String> versionApplicability =
      GeneratedColumn<String>(
        'version_applicability',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    subcategory,
    questionType,
    questionStyle,
    difficulty,
    component,
    questionText,
    optionsJson,
    correctAnswersJson,
    explanation,
    incorrectOptionExplanationsJson,
    scenario,
    examTip,
    technicalConcept,
    documentationReference,
    versionApplicability,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('subcategory')) {
      context.handle(
        _subcategoryMeta,
        subcategory.isAcceptableOrUnknown(
          data['subcategory']!,
          _subcategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subcategoryMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
        _questionTypeMeta,
        questionType.isAcceptableOrUnknown(
          data['question_type']!,
          _questionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('question_style')) {
      context.handle(
        _questionStyleMeta,
        questionStyle.isAcceptableOrUnknown(
          data['question_style']!,
          _questionStyleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionStyleMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('component')) {
      context.handle(
        _componentMeta,
        component.isAcceptableOrUnknown(data['component']!, _componentMeta),
      );
    } else if (isInserting) {
      context.missing(_componentMeta);
    }
    if (data.containsKey('question_text')) {
      context.handle(
        _questionTextMeta,
        questionText.isAcceptableOrUnknown(
          data['question_text']!,
          _questionTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTextMeta);
    }
    if (data.containsKey('options_json')) {
      context.handle(
        _optionsJsonMeta,
        optionsJson.isAcceptableOrUnknown(
          data['options_json']!,
          _optionsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_optionsJsonMeta);
    }
    if (data.containsKey('correct_answers_json')) {
      context.handle(
        _correctAnswersJsonMeta,
        correctAnswersJson.isAcceptableOrUnknown(
          data['correct_answers_json']!,
          _correctAnswersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersJsonMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('incorrect_option_explanations_json')) {
      context.handle(
        _incorrectOptionExplanationsJsonMeta,
        incorrectOptionExplanationsJson.isAcceptableOrUnknown(
          data['incorrect_option_explanations_json']!,
          _incorrectOptionExplanationsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_incorrectOptionExplanationsJsonMeta);
    }
    if (data.containsKey('scenario')) {
      context.handle(
        _scenarioMeta,
        scenario.isAcceptableOrUnknown(data['scenario']!, _scenarioMeta),
      );
    } else if (isInserting) {
      context.missing(_scenarioMeta);
    }
    if (data.containsKey('exam_tip')) {
      context.handle(
        _examTipMeta,
        examTip.isAcceptableOrUnknown(data['exam_tip']!, _examTipMeta),
      );
    } else if (isInserting) {
      context.missing(_examTipMeta);
    }
    if (data.containsKey('technical_concept')) {
      context.handle(
        _technicalConceptMeta,
        technicalConcept.isAcceptableOrUnknown(
          data['technical_concept']!,
          _technicalConceptMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_technicalConceptMeta);
    }
    if (data.containsKey('documentation_reference')) {
      context.handle(
        _documentationReferenceMeta,
        documentationReference.isAcceptableOrUnknown(
          data['documentation_reference']!,
          _documentationReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentationReferenceMeta);
    }
    if (data.containsKey('version_applicability')) {
      context.handle(
        _versionApplicabilityMeta,
        versionApplicability.isAcceptableOrUnknown(
          data['version_applicability']!,
          _versionApplicabilityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionApplicabilityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      subcategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory'],
      )!,
      questionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_type'],
      )!,
      questionStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_style'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      component: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component'],
      )!,
      questionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_text'],
      )!,
      optionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_json'],
      )!,
      correctAnswersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correct_answers_json'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      )!,
      incorrectOptionExplanationsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incorrect_option_explanations_json'],
      )!,
      scenario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scenario'],
      )!,
      examTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_tip'],
      )!,
      technicalConcept: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technical_concept'],
      )!,
      documentationReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}documentation_reference'],
      )!,
      versionApplicability: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version_applicability'],
      )!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class QuestionRow extends DataClass implements Insertable<QuestionRow> {
  final String id;
  final String categoryId;
  final String subcategory;
  final String questionType;
  final String questionStyle;
  final int difficulty;
  final String component;
  final String questionText;
  final String optionsJson;
  final String correctAnswersJson;
  final String explanation;
  final String incorrectOptionExplanationsJson;
  final String scenario;
  final String examTip;
  final String technicalConcept;
  final String documentationReference;
  final String versionApplicability;
  const QuestionRow({
    required this.id,
    required this.categoryId,
    required this.subcategory,
    required this.questionType,
    required this.questionStyle,
    required this.difficulty,
    required this.component,
    required this.questionText,
    required this.optionsJson,
    required this.correctAnswersJson,
    required this.explanation,
    required this.incorrectOptionExplanationsJson,
    required this.scenario,
    required this.examTip,
    required this.technicalConcept,
    required this.documentationReference,
    required this.versionApplicability,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['subcategory'] = Variable<String>(subcategory);
    map['question_type'] = Variable<String>(questionType);
    map['question_style'] = Variable<String>(questionStyle);
    map['difficulty'] = Variable<int>(difficulty);
    map['component'] = Variable<String>(component);
    map['question_text'] = Variable<String>(questionText);
    map['options_json'] = Variable<String>(optionsJson);
    map['correct_answers_json'] = Variable<String>(correctAnswersJson);
    map['explanation'] = Variable<String>(explanation);
    map['incorrect_option_explanations_json'] = Variable<String>(
      incorrectOptionExplanationsJson,
    );
    map['scenario'] = Variable<String>(scenario);
    map['exam_tip'] = Variable<String>(examTip);
    map['technical_concept'] = Variable<String>(technicalConcept);
    map['documentation_reference'] = Variable<String>(documentationReference);
    map['version_applicability'] = Variable<String>(versionApplicability);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      subcategory: Value(subcategory),
      questionType: Value(questionType),
      questionStyle: Value(questionStyle),
      difficulty: Value(difficulty),
      component: Value(component),
      questionText: Value(questionText),
      optionsJson: Value(optionsJson),
      correctAnswersJson: Value(correctAnswersJson),
      explanation: Value(explanation),
      incorrectOptionExplanationsJson: Value(incorrectOptionExplanationsJson),
      scenario: Value(scenario),
      examTip: Value(examTip),
      technicalConcept: Value(technicalConcept),
      documentationReference: Value(documentationReference),
      versionApplicability: Value(versionApplicability),
    );
  }

  factory QuestionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionRow(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      subcategory: serializer.fromJson<String>(json['subcategory']),
      questionType: serializer.fromJson<String>(json['questionType']),
      questionStyle: serializer.fromJson<String>(json['questionStyle']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      component: serializer.fromJson<String>(json['component']),
      questionText: serializer.fromJson<String>(json['questionText']),
      optionsJson: serializer.fromJson<String>(json['optionsJson']),
      correctAnswersJson: serializer.fromJson<String>(
        json['correctAnswersJson'],
      ),
      explanation: serializer.fromJson<String>(json['explanation']),
      incorrectOptionExplanationsJson: serializer.fromJson<String>(
        json['incorrectOptionExplanationsJson'],
      ),
      scenario: serializer.fromJson<String>(json['scenario']),
      examTip: serializer.fromJson<String>(json['examTip']),
      technicalConcept: serializer.fromJson<String>(json['technicalConcept']),
      documentationReference: serializer.fromJson<String>(
        json['documentationReference'],
      ),
      versionApplicability: serializer.fromJson<String>(
        json['versionApplicability'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'subcategory': serializer.toJson<String>(subcategory),
      'questionType': serializer.toJson<String>(questionType),
      'questionStyle': serializer.toJson<String>(questionStyle),
      'difficulty': serializer.toJson<int>(difficulty),
      'component': serializer.toJson<String>(component),
      'questionText': serializer.toJson<String>(questionText),
      'optionsJson': serializer.toJson<String>(optionsJson),
      'correctAnswersJson': serializer.toJson<String>(correctAnswersJson),
      'explanation': serializer.toJson<String>(explanation),
      'incorrectOptionExplanationsJson': serializer.toJson<String>(
        incorrectOptionExplanationsJson,
      ),
      'scenario': serializer.toJson<String>(scenario),
      'examTip': serializer.toJson<String>(examTip),
      'technicalConcept': serializer.toJson<String>(technicalConcept),
      'documentationReference': serializer.toJson<String>(
        documentationReference,
      ),
      'versionApplicability': serializer.toJson<String>(versionApplicability),
    };
  }

  QuestionRow copyWith({
    String? id,
    String? categoryId,
    String? subcategory,
    String? questionType,
    String? questionStyle,
    int? difficulty,
    String? component,
    String? questionText,
    String? optionsJson,
    String? correctAnswersJson,
    String? explanation,
    String? incorrectOptionExplanationsJson,
    String? scenario,
    String? examTip,
    String? technicalConcept,
    String? documentationReference,
    String? versionApplicability,
  }) => QuestionRow(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    subcategory: subcategory ?? this.subcategory,
    questionType: questionType ?? this.questionType,
    questionStyle: questionStyle ?? this.questionStyle,
    difficulty: difficulty ?? this.difficulty,
    component: component ?? this.component,
    questionText: questionText ?? this.questionText,
    optionsJson: optionsJson ?? this.optionsJson,
    correctAnswersJson: correctAnswersJson ?? this.correctAnswersJson,
    explanation: explanation ?? this.explanation,
    incorrectOptionExplanationsJson:
        incorrectOptionExplanationsJson ?? this.incorrectOptionExplanationsJson,
    scenario: scenario ?? this.scenario,
    examTip: examTip ?? this.examTip,
    technicalConcept: technicalConcept ?? this.technicalConcept,
    documentationReference:
        documentationReference ?? this.documentationReference,
    versionApplicability: versionApplicability ?? this.versionApplicability,
  );
  QuestionRow copyWithCompanion(QuestionsCompanion data) {
    return QuestionRow(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      subcategory: data.subcategory.present
          ? data.subcategory.value
          : this.subcategory,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      questionStyle: data.questionStyle.present
          ? data.questionStyle.value
          : this.questionStyle,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      component: data.component.present ? data.component.value : this.component,
      questionText: data.questionText.present
          ? data.questionText.value
          : this.questionText,
      optionsJson: data.optionsJson.present
          ? data.optionsJson.value
          : this.optionsJson,
      correctAnswersJson: data.correctAnswersJson.present
          ? data.correctAnswersJson.value
          : this.correctAnswersJson,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      incorrectOptionExplanationsJson:
          data.incorrectOptionExplanationsJson.present
          ? data.incorrectOptionExplanationsJson.value
          : this.incorrectOptionExplanationsJson,
      scenario: data.scenario.present ? data.scenario.value : this.scenario,
      examTip: data.examTip.present ? data.examTip.value : this.examTip,
      technicalConcept: data.technicalConcept.present
          ? data.technicalConcept.value
          : this.technicalConcept,
      documentationReference: data.documentationReference.present
          ? data.documentationReference.value
          : this.documentationReference,
      versionApplicability: data.versionApplicability.present
          ? data.versionApplicability.value
          : this.versionApplicability,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionRow(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('subcategory: $subcategory, ')
          ..write('questionType: $questionType, ')
          ..write('questionStyle: $questionStyle, ')
          ..write('difficulty: $difficulty, ')
          ..write('component: $component, ')
          ..write('questionText: $questionText, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctAnswersJson: $correctAnswersJson, ')
          ..write('explanation: $explanation, ')
          ..write(
            'incorrectOptionExplanationsJson: $incorrectOptionExplanationsJson, ',
          )
          ..write('scenario: $scenario, ')
          ..write('examTip: $examTip, ')
          ..write('technicalConcept: $technicalConcept, ')
          ..write('documentationReference: $documentationReference, ')
          ..write('versionApplicability: $versionApplicability')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    subcategory,
    questionType,
    questionStyle,
    difficulty,
    component,
    questionText,
    optionsJson,
    correctAnswersJson,
    explanation,
    incorrectOptionExplanationsJson,
    scenario,
    examTip,
    technicalConcept,
    documentationReference,
    versionApplicability,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionRow &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.subcategory == this.subcategory &&
          other.questionType == this.questionType &&
          other.questionStyle == this.questionStyle &&
          other.difficulty == this.difficulty &&
          other.component == this.component &&
          other.questionText == this.questionText &&
          other.optionsJson == this.optionsJson &&
          other.correctAnswersJson == this.correctAnswersJson &&
          other.explanation == this.explanation &&
          other.incorrectOptionExplanationsJson ==
              this.incorrectOptionExplanationsJson &&
          other.scenario == this.scenario &&
          other.examTip == this.examTip &&
          other.technicalConcept == this.technicalConcept &&
          other.documentationReference == this.documentationReference &&
          other.versionApplicability == this.versionApplicability);
}

class QuestionsCompanion extends UpdateCompanion<QuestionRow> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> subcategory;
  final Value<String> questionType;
  final Value<String> questionStyle;
  final Value<int> difficulty;
  final Value<String> component;
  final Value<String> questionText;
  final Value<String> optionsJson;
  final Value<String> correctAnswersJson;
  final Value<String> explanation;
  final Value<String> incorrectOptionExplanationsJson;
  final Value<String> scenario;
  final Value<String> examTip;
  final Value<String> technicalConcept;
  final Value<String> documentationReference;
  final Value<String> versionApplicability;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.questionType = const Value.absent(),
    this.questionStyle = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.component = const Value.absent(),
    this.questionText = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.correctAnswersJson = const Value.absent(),
    this.explanation = const Value.absent(),
    this.incorrectOptionExplanationsJson = const Value.absent(),
    this.scenario = const Value.absent(),
    this.examTip = const Value.absent(),
    this.technicalConcept = const Value.absent(),
    this.documentationReference = const Value.absent(),
    this.versionApplicability = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    required String categoryId,
    required String subcategory,
    required String questionType,
    required String questionStyle,
    required int difficulty,
    required String component,
    required String questionText,
    required String optionsJson,
    required String correctAnswersJson,
    required String explanation,
    required String incorrectOptionExplanationsJson,
    required String scenario,
    required String examTip,
    required String technicalConcept,
    required String documentationReference,
    required String versionApplicability,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       subcategory = Value(subcategory),
       questionType = Value(questionType),
       questionStyle = Value(questionStyle),
       difficulty = Value(difficulty),
       component = Value(component),
       questionText = Value(questionText),
       optionsJson = Value(optionsJson),
       correctAnswersJson = Value(correctAnswersJson),
       explanation = Value(explanation),
       incorrectOptionExplanationsJson = Value(incorrectOptionExplanationsJson),
       scenario = Value(scenario),
       examTip = Value(examTip),
       technicalConcept = Value(technicalConcept),
       documentationReference = Value(documentationReference),
       versionApplicability = Value(versionApplicability);
  static Insertable<QuestionRow> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? subcategory,
    Expression<String>? questionType,
    Expression<String>? questionStyle,
    Expression<int>? difficulty,
    Expression<String>? component,
    Expression<String>? questionText,
    Expression<String>? optionsJson,
    Expression<String>? correctAnswersJson,
    Expression<String>? explanation,
    Expression<String>? incorrectOptionExplanationsJson,
    Expression<String>? scenario,
    Expression<String>? examTip,
    Expression<String>? technicalConcept,
    Expression<String>? documentationReference,
    Expression<String>? versionApplicability,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (subcategory != null) 'subcategory': subcategory,
      if (questionType != null) 'question_type': questionType,
      if (questionStyle != null) 'question_style': questionStyle,
      if (difficulty != null) 'difficulty': difficulty,
      if (component != null) 'component': component,
      if (questionText != null) 'question_text': questionText,
      if (optionsJson != null) 'options_json': optionsJson,
      if (correctAnswersJson != null)
        'correct_answers_json': correctAnswersJson,
      if (explanation != null) 'explanation': explanation,
      if (incorrectOptionExplanationsJson != null)
        'incorrect_option_explanations_json': incorrectOptionExplanationsJson,
      if (scenario != null) 'scenario': scenario,
      if (examTip != null) 'exam_tip': examTip,
      if (technicalConcept != null) 'technical_concept': technicalConcept,
      if (documentationReference != null)
        'documentation_reference': documentationReference,
      if (versionApplicability != null)
        'version_applicability': versionApplicability,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? subcategory,
    Value<String>? questionType,
    Value<String>? questionStyle,
    Value<int>? difficulty,
    Value<String>? component,
    Value<String>? questionText,
    Value<String>? optionsJson,
    Value<String>? correctAnswersJson,
    Value<String>? explanation,
    Value<String>? incorrectOptionExplanationsJson,
    Value<String>? scenario,
    Value<String>? examTip,
    Value<String>? technicalConcept,
    Value<String>? documentationReference,
    Value<String>? versionApplicability,
    Value<int>? rowid,
  }) {
    return QuestionsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      questionType: questionType ?? this.questionType,
      questionStyle: questionStyle ?? this.questionStyle,
      difficulty: difficulty ?? this.difficulty,
      component: component ?? this.component,
      questionText: questionText ?? this.questionText,
      optionsJson: optionsJson ?? this.optionsJson,
      correctAnswersJson: correctAnswersJson ?? this.correctAnswersJson,
      explanation: explanation ?? this.explanation,
      incorrectOptionExplanationsJson:
          incorrectOptionExplanationsJson ??
          this.incorrectOptionExplanationsJson,
      scenario: scenario ?? this.scenario,
      examTip: examTip ?? this.examTip,
      technicalConcept: technicalConcept ?? this.technicalConcept,
      documentationReference:
          documentationReference ?? this.documentationReference,
      versionApplicability: versionApplicability ?? this.versionApplicability,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (questionStyle.present) {
      map['question_style'] = Variable<String>(questionStyle.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (component.present) {
      map['component'] = Variable<String>(component.value);
    }
    if (questionText.present) {
      map['question_text'] = Variable<String>(questionText.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (correctAnswersJson.present) {
      map['correct_answers_json'] = Variable<String>(correctAnswersJson.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (incorrectOptionExplanationsJson.present) {
      map['incorrect_option_explanations_json'] = Variable<String>(
        incorrectOptionExplanationsJson.value,
      );
    }
    if (scenario.present) {
      map['scenario'] = Variable<String>(scenario.value);
    }
    if (examTip.present) {
      map['exam_tip'] = Variable<String>(examTip.value);
    }
    if (technicalConcept.present) {
      map['technical_concept'] = Variable<String>(technicalConcept.value);
    }
    if (documentationReference.present) {
      map['documentation_reference'] = Variable<String>(
        documentationReference.value,
      );
    }
    if (versionApplicability.present) {
      map['version_applicability'] = Variable<String>(
        versionApplicability.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('subcategory: $subcategory, ')
          ..write('questionType: $questionType, ')
          ..write('questionStyle: $questionStyle, ')
          ..write('difficulty: $difficulty, ')
          ..write('component: $component, ')
          ..write('questionText: $questionText, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctAnswersJson: $correctAnswersJson, ')
          ..write('explanation: $explanation, ')
          ..write(
            'incorrectOptionExplanationsJson: $incorrectOptionExplanationsJson, ',
          )
          ..write('scenario: $scenario, ')
          ..write('examTip: $examTip, ')
          ..write('technicalConcept: $technicalConcept, ')
          ..write('documentationReference: $documentationReference, ')
          ..write('versionApplicability: $versionApplicability, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAnswersTable extends UserAnswers
    with TableInfo<$UserAnswersTable, UserAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _selectedAnswersJsonMeta =
      const VerificationMeta('selectedAnswersJson');
  @override
  late final GeneratedColumn<String> selectedAnswersJson =
      GeneratedColumn<String>(
        'selected_answers_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _attemptNumberMeta = const VerificationMeta(
    'attemptNumber',
  );
  @override
  late final GeneratedColumn<int> attemptNumber = GeneratedColumn<int>(
    'attempt_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    selectedAnswersJson,
    isCorrect,
    attemptNumber,
    source,
    answeredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAnswer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('selected_answers_json')) {
      context.handle(
        _selectedAnswersJsonMeta,
        selectedAnswersJson.isAcceptableOrUnknown(
          data['selected_answers_json']!,
          _selectedAnswersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectedAnswersJsonMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('attempt_number')) {
      context.handle(
        _attemptNumberMeta,
        attemptNumber.isAcceptableOrUnknown(
          data['attempt_number']!,
          _attemptNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptNumberMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAnswer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      selectedAnswersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_answers_json'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      attemptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_number'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answered_at'],
      )!,
    );
  }

  @override
  $UserAnswersTable createAlias(String alias) {
    return $UserAnswersTable(attachedDatabase, alias);
  }
}

class UserAnswer extends DataClass implements Insertable<UserAnswer> {
  final int id;
  final String questionId;
  final String selectedAnswersJson;
  final bool isCorrect;
  final int attemptNumber;

  /// learning | practice | exam
  final String source;
  final DateTime answeredAt;
  const UserAnswer({
    required this.id,
    required this.questionId,
    required this.selectedAnswersJson,
    required this.isCorrect,
    required this.attemptNumber,
    required this.source,
    required this.answeredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['selected_answers_json'] = Variable<String>(selectedAnswersJson);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['attempt_number'] = Variable<int>(attemptNumber);
    map['source'] = Variable<String>(source);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    return map;
  }

  UserAnswersCompanion toCompanion(bool nullToAbsent) {
    return UserAnswersCompanion(
      id: Value(id),
      questionId: Value(questionId),
      selectedAnswersJson: Value(selectedAnswersJson),
      isCorrect: Value(isCorrect),
      attemptNumber: Value(attemptNumber),
      source: Value(source),
      answeredAt: Value(answeredAt),
    );
  }

  factory UserAnswer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAnswer(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      selectedAnswersJson: serializer.fromJson<String>(
        json['selectedAnswersJson'],
      ),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      attemptNumber: serializer.fromJson<int>(json['attemptNumber']),
      source: serializer.fromJson<String>(json['source']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'selectedAnswersJson': serializer.toJson<String>(selectedAnswersJson),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'attemptNumber': serializer.toJson<int>(attemptNumber),
      'source': serializer.toJson<String>(source),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
    };
  }

  UserAnswer copyWith({
    int? id,
    String? questionId,
    String? selectedAnswersJson,
    bool? isCorrect,
    int? attemptNumber,
    String? source,
    DateTime? answeredAt,
  }) => UserAnswer(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    selectedAnswersJson: selectedAnswersJson ?? this.selectedAnswersJson,
    isCorrect: isCorrect ?? this.isCorrect,
    attemptNumber: attemptNumber ?? this.attemptNumber,
    source: source ?? this.source,
    answeredAt: answeredAt ?? this.answeredAt,
  );
  UserAnswer copyWithCompanion(UserAnswersCompanion data) {
    return UserAnswer(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      selectedAnswersJson: data.selectedAnswersJson.present
          ? data.selectedAnswersJson.value
          : this.selectedAnswersJson,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      attemptNumber: data.attemptNumber.present
          ? data.attemptNumber.value
          : this.attemptNumber,
      source: data.source.present ? data.source.value : this.source,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAnswer(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('selectedAnswersJson: $selectedAnswersJson, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('source: $source, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questionId,
    selectedAnswersJson,
    isCorrect,
    attemptNumber,
    source,
    answeredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAnswer &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.selectedAnswersJson == this.selectedAnswersJson &&
          other.isCorrect == this.isCorrect &&
          other.attemptNumber == this.attemptNumber &&
          other.source == this.source &&
          other.answeredAt == this.answeredAt);
}

class UserAnswersCompanion extends UpdateCompanion<UserAnswer> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<String> selectedAnswersJson;
  final Value<bool> isCorrect;
  final Value<int> attemptNumber;
  final Value<String> source;
  final Value<DateTime> answeredAt;
  const UserAnswersCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.selectedAnswersJson = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.attemptNumber = const Value.absent(),
    this.source = const Value.absent(),
    this.answeredAt = const Value.absent(),
  });
  UserAnswersCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    required String selectedAnswersJson,
    required bool isCorrect,
    required int attemptNumber,
    required String source,
    required DateTime answeredAt,
  }) : questionId = Value(questionId),
       selectedAnswersJson = Value(selectedAnswersJson),
       isCorrect = Value(isCorrect),
       attemptNumber = Value(attemptNumber),
       source = Value(source),
       answeredAt = Value(answeredAt);
  static Insertable<UserAnswer> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<String>? selectedAnswersJson,
    Expression<bool>? isCorrect,
    Expression<int>? attemptNumber,
    Expression<String>? source,
    Expression<DateTime>? answeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (selectedAnswersJson != null)
        'selected_answers_json': selectedAnswersJson,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (attemptNumber != null) 'attempt_number': attemptNumber,
      if (source != null) 'source': source,
      if (answeredAt != null) 'answered_at': answeredAt,
    });
  }

  UserAnswersCompanion copyWith({
    Value<int>? id,
    Value<String>? questionId,
    Value<String>? selectedAnswersJson,
    Value<bool>? isCorrect,
    Value<int>? attemptNumber,
    Value<String>? source,
    Value<DateTime>? answeredAt,
  }) {
    return UserAnswersCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      selectedAnswersJson: selectedAnswersJson ?? this.selectedAnswersJson,
      isCorrect: isCorrect ?? this.isCorrect,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      source: source ?? this.source,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (selectedAnswersJson.present) {
      map['selected_answers_json'] = Variable<String>(
        selectedAnswersJson.value,
      );
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (attemptNumber.present) {
      map['attempt_number'] = Variable<int>(attemptNumber.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAnswersCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('selectedAnswersJson: $selectedAnswersJson, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('source: $source, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }
}

class $LearningRoundsTable extends LearningRounds
    with TableInfo<$LearningRoundsTable, LearningRound> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningRoundsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundNumberMeta = const VerificationMeta(
    'roundNumber',
  );
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
    'round_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdsJsonMeta = const VerificationMeta(
    'questionIdsJson',
  );
  @override
  late final GeneratedColumn<String> questionIdsJson = GeneratedColumn<String>(
    'question_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _optionOrderJsonMeta = const VerificationMeta(
    'optionOrderJson',
  );
  @override
  late final GeneratedColumn<String> optionOrderJson = GeneratedColumn<String>(
    'option_order_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _currentIndexMeta = const VerificationMeta(
    'currentIndex',
  );
  @override
  late final GeneratedColumn<int> currentIndex = GeneratedColumn<int>(
    'current_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    mode,
    roundNumber,
    questionIdsJson,
    answersJson,
    optionOrderJson,
    currentIndex,
    score,
    status,
    startedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_rounds';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningRound> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('round_number')) {
      context.handle(
        _roundNumberMeta,
        roundNumber.isAcceptableOrUnknown(
          data['round_number']!,
          _roundNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('question_ids_json')) {
      context.handle(
        _questionIdsJsonMeta,
        questionIdsJson.isAcceptableOrUnknown(
          data['question_ids_json']!,
          _questionIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionIdsJsonMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    }
    if (data.containsKey('option_order_json')) {
      context.handle(
        _optionOrderJsonMeta,
        optionOrderJson.isAcceptableOrUnknown(
          data['option_order_json']!,
          _optionOrderJsonMeta,
        ),
      );
    }
    if (data.containsKey('current_index')) {
      context.handle(
        _currentIndexMeta,
        currentIndex.isAcceptableOrUnknown(
          data['current_index']!,
          _currentIndexMeta,
        ),
      );
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningRound map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningRound(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      roundNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_number'],
      )!,
      questionIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_ids_json'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      optionOrderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_order_json'],
      )!,
      currentIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_index'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $LearningRoundsTable createAlias(String alias) {
    return $LearningRoundsTable(attachedDatabase, alias);
  }
}

class LearningRound extends DataClass implements Insertable<LearningRound> {
  final int id;

  /// Null for cross-category practice rounds.
  final String? categoryId;

  /// learning | practice-* modes
  final String mode;
  final int roundNumber;
  final String questionIdsJson;
  final String answersJson;
  final String optionOrderJson;
  final int currentIndex;
  final int? score;

  /// in_progress | passed | failed | completed
  final String status;
  final DateTime startedAt;
  final DateTime? completedAt;
  const LearningRound({
    required this.id,
    this.categoryId,
    required this.mode,
    required this.roundNumber,
    required this.questionIdsJson,
    required this.answersJson,
    required this.optionOrderJson,
    required this.currentIndex,
    this.score,
    required this.status,
    required this.startedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['mode'] = Variable<String>(mode);
    map['round_number'] = Variable<int>(roundNumber);
    map['question_ids_json'] = Variable<String>(questionIdsJson);
    map['answers_json'] = Variable<String>(answersJson);
    map['option_order_json'] = Variable<String>(optionOrderJson);
    map['current_index'] = Variable<int>(currentIndex);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<int>(score);
    }
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  LearningRoundsCompanion toCompanion(bool nullToAbsent) {
    return LearningRoundsCompanion(
      id: Value(id),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      mode: Value(mode),
      roundNumber: Value(roundNumber),
      questionIdsJson: Value(questionIdsJson),
      answersJson: Value(answersJson),
      optionOrderJson: Value(optionOrderJson),
      currentIndex: Value(currentIndex),
      score: score == null && nullToAbsent
          ? const Value.absent()
          : Value(score),
      status: Value(status),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory LearningRound.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningRound(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      mode: serializer.fromJson<String>(json['mode']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      questionIdsJson: serializer.fromJson<String>(json['questionIdsJson']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      optionOrderJson: serializer.fromJson<String>(json['optionOrderJson']),
      currentIndex: serializer.fromJson<int>(json['currentIndex']),
      score: serializer.fromJson<int?>(json['score']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<String?>(categoryId),
      'mode': serializer.toJson<String>(mode),
      'roundNumber': serializer.toJson<int>(roundNumber),
      'questionIdsJson': serializer.toJson<String>(questionIdsJson),
      'answersJson': serializer.toJson<String>(answersJson),
      'optionOrderJson': serializer.toJson<String>(optionOrderJson),
      'currentIndex': serializer.toJson<int>(currentIndex),
      'score': serializer.toJson<int?>(score),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  LearningRound copyWith({
    int? id,
    Value<String?> categoryId = const Value.absent(),
    String? mode,
    int? roundNumber,
    String? questionIdsJson,
    String? answersJson,
    String? optionOrderJson,
    int? currentIndex,
    Value<int?> score = const Value.absent(),
    String? status,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => LearningRound(
    id: id ?? this.id,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    mode: mode ?? this.mode,
    roundNumber: roundNumber ?? this.roundNumber,
    questionIdsJson: questionIdsJson ?? this.questionIdsJson,
    answersJson: answersJson ?? this.answersJson,
    optionOrderJson: optionOrderJson ?? this.optionOrderJson,
    currentIndex: currentIndex ?? this.currentIndex,
    score: score.present ? score.value : this.score,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  LearningRound copyWithCompanion(LearningRoundsCompanion data) {
    return LearningRound(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      mode: data.mode.present ? data.mode.value : this.mode,
      roundNumber: data.roundNumber.present
          ? data.roundNumber.value
          : this.roundNumber,
      questionIdsJson: data.questionIdsJson.present
          ? data.questionIdsJson.value
          : this.questionIdsJson,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      optionOrderJson: data.optionOrderJson.present
          ? data.optionOrderJson.value
          : this.optionOrderJson,
      currentIndex: data.currentIndex.present
          ? data.currentIndex.value
          : this.currentIndex,
      score: data.score.present ? data.score.value : this.score,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningRound(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('mode: $mode, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('optionOrderJson: $optionOrderJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('score: $score, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    mode,
    roundNumber,
    questionIdsJson,
    answersJson,
    optionOrderJson,
    currentIndex,
    score,
    status,
    startedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningRound &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.mode == this.mode &&
          other.roundNumber == this.roundNumber &&
          other.questionIdsJson == this.questionIdsJson &&
          other.answersJson == this.answersJson &&
          other.optionOrderJson == this.optionOrderJson &&
          other.currentIndex == this.currentIndex &&
          other.score == this.score &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt);
}

class LearningRoundsCompanion extends UpdateCompanion<LearningRound> {
  final Value<int> id;
  final Value<String?> categoryId;
  final Value<String> mode;
  final Value<int> roundNumber;
  final Value<String> questionIdsJson;
  final Value<String> answersJson;
  final Value<String> optionOrderJson;
  final Value<int> currentIndex;
  final Value<int?> score;
  final Value<String> status;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  const LearningRoundsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.mode = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.questionIdsJson = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.optionOrderJson = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.score = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  LearningRoundsCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String mode,
    required int roundNumber,
    required String questionIdsJson,
    this.answersJson = const Value.absent(),
    this.optionOrderJson = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.score = const Value.absent(),
    required String status,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
  }) : mode = Value(mode),
       roundNumber = Value(roundNumber),
       questionIdsJson = Value(questionIdsJson),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<LearningRound> custom({
    Expression<int>? id,
    Expression<String>? categoryId,
    Expression<String>? mode,
    Expression<int>? roundNumber,
    Expression<String>? questionIdsJson,
    Expression<String>? answersJson,
    Expression<String>? optionOrderJson,
    Expression<int>? currentIndex,
    Expression<int>? score,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (mode != null) 'mode': mode,
      if (roundNumber != null) 'round_number': roundNumber,
      if (questionIdsJson != null) 'question_ids_json': questionIdsJson,
      if (answersJson != null) 'answers_json': answersJson,
      if (optionOrderJson != null) 'option_order_json': optionOrderJson,
      if (currentIndex != null) 'current_index': currentIndex,
      if (score != null) 'score': score,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  LearningRoundsCompanion copyWith({
    Value<int>? id,
    Value<String?>? categoryId,
    Value<String>? mode,
    Value<int>? roundNumber,
    Value<String>? questionIdsJson,
    Value<String>? answersJson,
    Value<String>? optionOrderJson,
    Value<int>? currentIndex,
    Value<int?>? score,
    Value<String>? status,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
  }) {
    return LearningRoundsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      mode: mode ?? this.mode,
      roundNumber: roundNumber ?? this.roundNumber,
      questionIdsJson: questionIdsJson ?? this.questionIdsJson,
      answersJson: answersJson ?? this.answersJson,
      optionOrderJson: optionOrderJson ?? this.optionOrderJson,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (questionIdsJson.present) {
      map['question_ids_json'] = Variable<String>(questionIdsJson.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (optionOrderJson.present) {
      map['option_order_json'] = Variable<String>(optionOrderJson.value);
    }
    if (currentIndex.present) {
      map['current_index'] = Variable<int>(currentIndex.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningRoundsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('mode: $mode, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('optionOrderJson: $optionOrderJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('score: $score, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryProgressTable extends CategoryProgress
    with TableInfo<$CategoryProgressTable, CategoryProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _questionsCoveredMeta = const VerificationMeta(
    'questionsCovered',
  );
  @override
  late final GeneratedColumn<int> questionsCovered = GeneratedColumn<int>(
    'questions_covered',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _roundsPassedMeta = const VerificationMeta(
    'roundsPassed',
  );
  @override
  late final GeneratedColumn<int> roundsPassed = GeneratedColumn<int>(
    'rounds_passed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _roundsFailedMeta = const VerificationMeta(
    'roundsFailed',
  );
  @override
  late final GeneratedColumn<int> roundsFailed = GeneratedColumn<int>(
    'rounds_failed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completionPercentageMeta =
      const VerificationMeta('completionPercentage');
  @override
  late final GeneratedColumn<double> completionPercentage =
      GeneratedColumn<double>(
        'completion_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _masteryStatusMeta = const VerificationMeta(
    'masteryStatus',
  );
  @override
  late final GeneratedColumn<String> masteryStatus = GeneratedColumn<String>(
    'mastery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('not_started'),
  );
  static const VerificationMeta _coveredQuestionIdsJsonMeta =
      const VerificationMeta('coveredQuestionIdsJson');
  @override
  late final GeneratedColumn<String> coveredQuestionIdsJson =
      GeneratedColumn<String>(
        'covered_question_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    questionsCovered,
    roundsPassed,
    roundsFailed,
    completionPercentage,
    masteryStatus,
    coveredQuestionIdsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('questions_covered')) {
      context.handle(
        _questionsCoveredMeta,
        questionsCovered.isAcceptableOrUnknown(
          data['questions_covered']!,
          _questionsCoveredMeta,
        ),
      );
    }
    if (data.containsKey('rounds_passed')) {
      context.handle(
        _roundsPassedMeta,
        roundsPassed.isAcceptableOrUnknown(
          data['rounds_passed']!,
          _roundsPassedMeta,
        ),
      );
    }
    if (data.containsKey('rounds_failed')) {
      context.handle(
        _roundsFailedMeta,
        roundsFailed.isAcceptableOrUnknown(
          data['rounds_failed']!,
          _roundsFailedMeta,
        ),
      );
    }
    if (data.containsKey('completion_percentage')) {
      context.handle(
        _completionPercentageMeta,
        completionPercentage.isAcceptableOrUnknown(
          data['completion_percentage']!,
          _completionPercentageMeta,
        ),
      );
    }
    if (data.containsKey('mastery_status')) {
      context.handle(
        _masteryStatusMeta,
        masteryStatus.isAcceptableOrUnknown(
          data['mastery_status']!,
          _masteryStatusMeta,
        ),
      );
    }
    if (data.containsKey('covered_question_ids_json')) {
      context.handle(
        _coveredQuestionIdsJsonMeta,
        coveredQuestionIdsJson.isAcceptableOrUnknown(
          data['covered_question_ids_json']!,
          _coveredQuestionIdsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      questionsCovered: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}questions_covered'],
      )!,
      roundsPassed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounds_passed'],
      )!,
      roundsFailed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounds_failed'],
      )!,
      completionPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}completion_percentage'],
      )!,
      masteryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_status'],
      )!,
      coveredQuestionIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}covered_question_ids_json'],
      )!,
    );
  }

  @override
  $CategoryProgressTable createAlias(String alias) {
    return $CategoryProgressTable(attachedDatabase, alias);
  }
}

class CategoryProgressData extends DataClass
    implements Insertable<CategoryProgressData> {
  final int id;
  final String categoryId;
  final int questionsCovered;
  final int roundsPassed;
  final int roundsFailed;
  final double completionPercentage;

  /// not_started | in_progress | retry_required | mastered
  final String masteryStatus;

  /// Question IDs covered by a passed (5/5) round.
  final String coveredQuestionIdsJson;
  const CategoryProgressData({
    required this.id,
    required this.categoryId,
    required this.questionsCovered,
    required this.roundsPassed,
    required this.roundsFailed,
    required this.completionPercentage,
    required this.masteryStatus,
    required this.coveredQuestionIdsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['questions_covered'] = Variable<int>(questionsCovered);
    map['rounds_passed'] = Variable<int>(roundsPassed);
    map['rounds_failed'] = Variable<int>(roundsFailed);
    map['completion_percentage'] = Variable<double>(completionPercentage);
    map['mastery_status'] = Variable<String>(masteryStatus);
    map['covered_question_ids_json'] = Variable<String>(coveredQuestionIdsJson);
    return map;
  }

  CategoryProgressCompanion toCompanion(bool nullToAbsent) {
    return CategoryProgressCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      questionsCovered: Value(questionsCovered),
      roundsPassed: Value(roundsPassed),
      roundsFailed: Value(roundsFailed),
      completionPercentage: Value(completionPercentage),
      masteryStatus: Value(masteryStatus),
      coveredQuestionIdsJson: Value(coveredQuestionIdsJson),
    );
  }

  factory CategoryProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryProgressData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      questionsCovered: serializer.fromJson<int>(json['questionsCovered']),
      roundsPassed: serializer.fromJson<int>(json['roundsPassed']),
      roundsFailed: serializer.fromJson<int>(json['roundsFailed']),
      completionPercentage: serializer.fromJson<double>(
        json['completionPercentage'],
      ),
      masteryStatus: serializer.fromJson<String>(json['masteryStatus']),
      coveredQuestionIdsJson: serializer.fromJson<String>(
        json['coveredQuestionIdsJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'questionsCovered': serializer.toJson<int>(questionsCovered),
      'roundsPassed': serializer.toJson<int>(roundsPassed),
      'roundsFailed': serializer.toJson<int>(roundsFailed),
      'completionPercentage': serializer.toJson<double>(completionPercentage),
      'masteryStatus': serializer.toJson<String>(masteryStatus),
      'coveredQuestionIdsJson': serializer.toJson<String>(
        coveredQuestionIdsJson,
      ),
    };
  }

  CategoryProgressData copyWith({
    int? id,
    String? categoryId,
    int? questionsCovered,
    int? roundsPassed,
    int? roundsFailed,
    double? completionPercentage,
    String? masteryStatus,
    String? coveredQuestionIdsJson,
  }) => CategoryProgressData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    questionsCovered: questionsCovered ?? this.questionsCovered,
    roundsPassed: roundsPassed ?? this.roundsPassed,
    roundsFailed: roundsFailed ?? this.roundsFailed,
    completionPercentage: completionPercentage ?? this.completionPercentage,
    masteryStatus: masteryStatus ?? this.masteryStatus,
    coveredQuestionIdsJson:
        coveredQuestionIdsJson ?? this.coveredQuestionIdsJson,
  );
  CategoryProgressData copyWithCompanion(CategoryProgressCompanion data) {
    return CategoryProgressData(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      questionsCovered: data.questionsCovered.present
          ? data.questionsCovered.value
          : this.questionsCovered,
      roundsPassed: data.roundsPassed.present
          ? data.roundsPassed.value
          : this.roundsPassed,
      roundsFailed: data.roundsFailed.present
          ? data.roundsFailed.value
          : this.roundsFailed,
      completionPercentage: data.completionPercentage.present
          ? data.completionPercentage.value
          : this.completionPercentage,
      masteryStatus: data.masteryStatus.present
          ? data.masteryStatus.value
          : this.masteryStatus,
      coveredQuestionIdsJson: data.coveredQuestionIdsJson.present
          ? data.coveredQuestionIdsJson.value
          : this.coveredQuestionIdsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryProgressData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('questionsCovered: $questionsCovered, ')
          ..write('roundsPassed: $roundsPassed, ')
          ..write('roundsFailed: $roundsFailed, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('coveredQuestionIdsJson: $coveredQuestionIdsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    questionsCovered,
    roundsPassed,
    roundsFailed,
    completionPercentage,
    masteryStatus,
    coveredQuestionIdsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryProgressData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.questionsCovered == this.questionsCovered &&
          other.roundsPassed == this.roundsPassed &&
          other.roundsFailed == this.roundsFailed &&
          other.completionPercentage == this.completionPercentage &&
          other.masteryStatus == this.masteryStatus &&
          other.coveredQuestionIdsJson == this.coveredQuestionIdsJson);
}

class CategoryProgressCompanion extends UpdateCompanion<CategoryProgressData> {
  final Value<int> id;
  final Value<String> categoryId;
  final Value<int> questionsCovered;
  final Value<int> roundsPassed;
  final Value<int> roundsFailed;
  final Value<double> completionPercentage;
  final Value<String> masteryStatus;
  final Value<String> coveredQuestionIdsJson;
  const CategoryProgressCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.questionsCovered = const Value.absent(),
    this.roundsPassed = const Value.absent(),
    this.roundsFailed = const Value.absent(),
    this.completionPercentage = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.coveredQuestionIdsJson = const Value.absent(),
  });
  CategoryProgressCompanion.insert({
    this.id = const Value.absent(),
    required String categoryId,
    this.questionsCovered = const Value.absent(),
    this.roundsPassed = const Value.absent(),
    this.roundsFailed = const Value.absent(),
    this.completionPercentage = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.coveredQuestionIdsJson = const Value.absent(),
  }) : categoryId = Value(categoryId);
  static Insertable<CategoryProgressData> custom({
    Expression<int>? id,
    Expression<String>? categoryId,
    Expression<int>? questionsCovered,
    Expression<int>? roundsPassed,
    Expression<int>? roundsFailed,
    Expression<double>? completionPercentage,
    Expression<String>? masteryStatus,
    Expression<String>? coveredQuestionIdsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (questionsCovered != null) 'questions_covered': questionsCovered,
      if (roundsPassed != null) 'rounds_passed': roundsPassed,
      if (roundsFailed != null) 'rounds_failed': roundsFailed,
      if (completionPercentage != null)
        'completion_percentage': completionPercentage,
      if (masteryStatus != null) 'mastery_status': masteryStatus,
      if (coveredQuestionIdsJson != null)
        'covered_question_ids_json': coveredQuestionIdsJson,
    });
  }

  CategoryProgressCompanion copyWith({
    Value<int>? id,
    Value<String>? categoryId,
    Value<int>? questionsCovered,
    Value<int>? roundsPassed,
    Value<int>? roundsFailed,
    Value<double>? completionPercentage,
    Value<String>? masteryStatus,
    Value<String>? coveredQuestionIdsJson,
  }) {
    return CategoryProgressCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      questionsCovered: questionsCovered ?? this.questionsCovered,
      roundsPassed: roundsPassed ?? this.roundsPassed,
      roundsFailed: roundsFailed ?? this.roundsFailed,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      masteryStatus: masteryStatus ?? this.masteryStatus,
      coveredQuestionIdsJson:
          coveredQuestionIdsJson ?? this.coveredQuestionIdsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (questionsCovered.present) {
      map['questions_covered'] = Variable<int>(questionsCovered.value);
    }
    if (roundsPassed.present) {
      map['rounds_passed'] = Variable<int>(roundsPassed.value);
    }
    if (roundsFailed.present) {
      map['rounds_failed'] = Variable<int>(roundsFailed.value);
    }
    if (completionPercentage.present) {
      map['completion_percentage'] = Variable<double>(
        completionPercentage.value,
      );
    }
    if (masteryStatus.present) {
      map['mastery_status'] = Variable<String>(masteryStatus.value);
    }
    if (coveredQuestionIdsJson.present) {
      map['covered_question_ids_json'] = Variable<String>(
        coveredQuestionIdsJson.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryProgressCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('questionsCovered: $questionsCovered, ')
          ..write('roundsPassed: $roundsPassed, ')
          ..write('roundsFailed: $roundsFailed, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('coveredQuestionIdsJson: $coveredQuestionIdsJson')
          ..write(')'))
        .toString();
  }
}

class $MockExamsTable extends MockExams
    with TableInfo<$MockExamsTable, MockExam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MockExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdsJsonMeta = const VerificationMeta(
    'questionIdsJson',
  );
  @override
  late final GeneratedColumn<String> questionIdsJson = GeneratedColumn<String>(
    'question_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _flagsJsonMeta = const VerificationMeta(
    'flagsJson',
  );
  @override
  late final GeneratedColumn<String> flagsJson = GeneratedColumn<String>(
    'flags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _optionOrderJsonMeta = const VerificationMeta(
    'optionOrderJson',
  );
  @override
  late final GeneratedColumn<String> optionOrderJson = GeneratedColumn<String>(
    'option_order_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _currentIndexMeta = const VerificationMeta(
    'currentIndex',
  );
  @override
  late final GeneratedColumn<int> currentIndex = GeneratedColumn<int>(
    'current_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _categoryBreakdownJsonMeta =
      const VerificationMeta('categoryBreakdownJson');
  @override
  late final GeneratedColumn<String> categoryBreakdownJson =
      GeneratedColumn<String>(
        'category_breakdown_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    deadline,
    durationSeconds,
    totalQuestions,
    correctAnswers,
    percentage,
    result,
    questionIdsJson,
    answersJson,
    flagsJson,
    optionOrderJson,
    currentIndex,
    categoryBreakdownJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mock_exams';
  @override
  VerificationContext validateIntegrity(
    Insertable<MockExam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('question_ids_json')) {
      context.handle(
        _questionIdsJsonMeta,
        questionIdsJson.isAcceptableOrUnknown(
          data['question_ids_json']!,
          _questionIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionIdsJsonMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    }
    if (data.containsKey('flags_json')) {
      context.handle(
        _flagsJsonMeta,
        flagsJson.isAcceptableOrUnknown(data['flags_json']!, _flagsJsonMeta),
      );
    }
    if (data.containsKey('option_order_json')) {
      context.handle(
        _optionOrderJsonMeta,
        optionOrderJson.isAcceptableOrUnknown(
          data['option_order_json']!,
          _optionOrderJsonMeta,
        ),
      );
    }
    if (data.containsKey('current_index')) {
      context.handle(
        _currentIndexMeta,
        currentIndex.isAcceptableOrUnknown(
          data['current_index']!,
          _currentIndexMeta,
        ),
      );
    }
    if (data.containsKey('category_breakdown_json')) {
      context.handle(
        _categoryBreakdownJsonMeta,
        categoryBreakdownJson.isAcceptableOrUnknown(
          data['category_breakdown_json']!,
          _categoryBreakdownJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MockExam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MockExam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      ),
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      questionIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_ids_json'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      flagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flags_json'],
      )!,
      optionOrderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_order_json'],
      )!,
      currentIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_index'],
      )!,
      categoryBreakdownJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_breakdown_json'],
      ),
    );
  }

  @override
  $MockExamsTable createAlias(String alias) {
    return $MockExamsTable(attachedDatabase, alias);
  }
}

class MockExam extends DataClass implements Insertable<MockExam> {
  final int id;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime deadline;
  final int? durationSeconds;
  final int totalQuestions;
  final int? correctAnswers;
  final double? percentage;

  /// in_progress | pass | fail
  final String result;
  final String questionIdsJson;
  final String answersJson;
  final String flagsJson;
  final String optionOrderJson;
  final int currentIndex;
  final String? categoryBreakdownJson;
  const MockExam({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.deadline,
    this.durationSeconds,
    required this.totalQuestions,
    this.correctAnswers,
    this.percentage,
    required this.result,
    required this.questionIdsJson,
    required this.answersJson,
    required this.flagsJson,
    required this.optionOrderJson,
    required this.currentIndex,
    this.categoryBreakdownJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['deadline'] = Variable<DateTime>(deadline);
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    map['total_questions'] = Variable<int>(totalQuestions);
    if (!nullToAbsent || correctAnswers != null) {
      map['correct_answers'] = Variable<int>(correctAnswers);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    map['result'] = Variable<String>(result);
    map['question_ids_json'] = Variable<String>(questionIdsJson);
    map['answers_json'] = Variable<String>(answersJson);
    map['flags_json'] = Variable<String>(flagsJson);
    map['option_order_json'] = Variable<String>(optionOrderJson);
    map['current_index'] = Variable<int>(currentIndex);
    if (!nullToAbsent || categoryBreakdownJson != null) {
      map['category_breakdown_json'] = Variable<String>(categoryBreakdownJson);
    }
    return map;
  }

  MockExamsCompanion toCompanion(bool nullToAbsent) {
    return MockExamsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      deadline: Value(deadline),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      totalQuestions: Value(totalQuestions),
      correctAnswers: correctAnswers == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswers),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      result: Value(result),
      questionIdsJson: Value(questionIdsJson),
      answersJson: Value(answersJson),
      flagsJson: Value(flagsJson),
      optionOrderJson: Value(optionOrderJson),
      currentIndex: Value(currentIndex),
      categoryBreakdownJson: categoryBreakdownJson == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryBreakdownJson),
    );
  }

  factory MockExam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MockExam(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      correctAnswers: serializer.fromJson<int?>(json['correctAnswers']),
      percentage: serializer.fromJson<double?>(json['percentage']),
      result: serializer.fromJson<String>(json['result']),
      questionIdsJson: serializer.fromJson<String>(json['questionIdsJson']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      flagsJson: serializer.fromJson<String>(json['flagsJson']),
      optionOrderJson: serializer.fromJson<String>(json['optionOrderJson']),
      currentIndex: serializer.fromJson<int>(json['currentIndex']),
      categoryBreakdownJson: serializer.fromJson<String?>(
        json['categoryBreakdownJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'deadline': serializer.toJson<DateTime>(deadline),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'correctAnswers': serializer.toJson<int?>(correctAnswers),
      'percentage': serializer.toJson<double?>(percentage),
      'result': serializer.toJson<String>(result),
      'questionIdsJson': serializer.toJson<String>(questionIdsJson),
      'answersJson': serializer.toJson<String>(answersJson),
      'flagsJson': serializer.toJson<String>(flagsJson),
      'optionOrderJson': serializer.toJson<String>(optionOrderJson),
      'currentIndex': serializer.toJson<int>(currentIndex),
      'categoryBreakdownJson': serializer.toJson<String?>(
        categoryBreakdownJson,
      ),
    };
  }

  MockExam copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? deadline,
    Value<int?> durationSeconds = const Value.absent(),
    int? totalQuestions,
    Value<int?> correctAnswers = const Value.absent(),
    Value<double?> percentage = const Value.absent(),
    String? result,
    String? questionIdsJson,
    String? answersJson,
    String? flagsJson,
    String? optionOrderJson,
    int? currentIndex,
    Value<String?> categoryBreakdownJson = const Value.absent(),
  }) => MockExam(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    deadline: deadline ?? this.deadline,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    correctAnswers: correctAnswers.present
        ? correctAnswers.value
        : this.correctAnswers,
    percentage: percentage.present ? percentage.value : this.percentage,
    result: result ?? this.result,
    questionIdsJson: questionIdsJson ?? this.questionIdsJson,
    answersJson: answersJson ?? this.answersJson,
    flagsJson: flagsJson ?? this.flagsJson,
    optionOrderJson: optionOrderJson ?? this.optionOrderJson,
    currentIndex: currentIndex ?? this.currentIndex,
    categoryBreakdownJson: categoryBreakdownJson.present
        ? categoryBreakdownJson.value
        : this.categoryBreakdownJson,
  );
  MockExam copyWithCompanion(MockExamsCompanion data) {
    return MockExam(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      result: data.result.present ? data.result.value : this.result,
      questionIdsJson: data.questionIdsJson.present
          ? data.questionIdsJson.value
          : this.questionIdsJson,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      flagsJson: data.flagsJson.present ? data.flagsJson.value : this.flagsJson,
      optionOrderJson: data.optionOrderJson.present
          ? data.optionOrderJson.value
          : this.optionOrderJson,
      currentIndex: data.currentIndex.present
          ? data.currentIndex.value
          : this.currentIndex,
      categoryBreakdownJson: data.categoryBreakdownJson.present
          ? data.categoryBreakdownJson.value
          : this.categoryBreakdownJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MockExam(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('deadline: $deadline, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('percentage: $percentage, ')
          ..write('result: $result, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('flagsJson: $flagsJson, ')
          ..write('optionOrderJson: $optionOrderJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('categoryBreakdownJson: $categoryBreakdownJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    deadline,
    durationSeconds,
    totalQuestions,
    correctAnswers,
    percentage,
    result,
    questionIdsJson,
    answersJson,
    flagsJson,
    optionOrderJson,
    currentIndex,
    categoryBreakdownJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MockExam &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.deadline == this.deadline &&
          other.durationSeconds == this.durationSeconds &&
          other.totalQuestions == this.totalQuestions &&
          other.correctAnswers == this.correctAnswers &&
          other.percentage == this.percentage &&
          other.result == this.result &&
          other.questionIdsJson == this.questionIdsJson &&
          other.answersJson == this.answersJson &&
          other.flagsJson == this.flagsJson &&
          other.optionOrderJson == this.optionOrderJson &&
          other.currentIndex == this.currentIndex &&
          other.categoryBreakdownJson == this.categoryBreakdownJson);
}

class MockExamsCompanion extends UpdateCompanion<MockExam> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> deadline;
  final Value<int?> durationSeconds;
  final Value<int> totalQuestions;
  final Value<int?> correctAnswers;
  final Value<double?> percentage;
  final Value<String> result;
  final Value<String> questionIdsJson;
  final Value<String> answersJson;
  final Value<String> flagsJson;
  final Value<String> optionOrderJson;
  final Value<int> currentIndex;
  final Value<String?> categoryBreakdownJson;
  const MockExamsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.deadline = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.percentage = const Value.absent(),
    this.result = const Value.absent(),
    this.questionIdsJson = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.flagsJson = const Value.absent(),
    this.optionOrderJson = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.categoryBreakdownJson = const Value.absent(),
  });
  MockExamsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required DateTime deadline,
    this.durationSeconds = const Value.absent(),
    required int totalQuestions,
    this.correctAnswers = const Value.absent(),
    this.percentage = const Value.absent(),
    required String result,
    required String questionIdsJson,
    this.answersJson = const Value.absent(),
    this.flagsJson = const Value.absent(),
    this.optionOrderJson = const Value.absent(),
    this.currentIndex = const Value.absent(),
    this.categoryBreakdownJson = const Value.absent(),
  }) : startedAt = Value(startedAt),
       deadline = Value(deadline),
       totalQuestions = Value(totalQuestions),
       result = Value(result),
       questionIdsJson = Value(questionIdsJson);
  static Insertable<MockExam> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? deadline,
    Expression<int>? durationSeconds,
    Expression<int>? totalQuestions,
    Expression<int>? correctAnswers,
    Expression<double>? percentage,
    Expression<String>? result,
    Expression<String>? questionIdsJson,
    Expression<String>? answersJson,
    Expression<String>? flagsJson,
    Expression<String>? optionOrderJson,
    Expression<int>? currentIndex,
    Expression<String>? categoryBreakdownJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (deadline != null) 'deadline': deadline,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (percentage != null) 'percentage': percentage,
      if (result != null) 'result': result,
      if (questionIdsJson != null) 'question_ids_json': questionIdsJson,
      if (answersJson != null) 'answers_json': answersJson,
      if (flagsJson != null) 'flags_json': flagsJson,
      if (optionOrderJson != null) 'option_order_json': optionOrderJson,
      if (currentIndex != null) 'current_index': currentIndex,
      if (categoryBreakdownJson != null)
        'category_breakdown_json': categoryBreakdownJson,
    });
  }

  MockExamsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? deadline,
    Value<int?>? durationSeconds,
    Value<int>? totalQuestions,
    Value<int?>? correctAnswers,
    Value<double?>? percentage,
    Value<String>? result,
    Value<String>? questionIdsJson,
    Value<String>? answersJson,
    Value<String>? flagsJson,
    Value<String>? optionOrderJson,
    Value<int>? currentIndex,
    Value<String?>? categoryBreakdownJson,
  }) {
    return MockExamsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      deadline: deadline ?? this.deadline,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      percentage: percentage ?? this.percentage,
      result: result ?? this.result,
      questionIdsJson: questionIdsJson ?? this.questionIdsJson,
      answersJson: answersJson ?? this.answersJson,
      flagsJson: flagsJson ?? this.flagsJson,
      optionOrderJson: optionOrderJson ?? this.optionOrderJson,
      currentIndex: currentIndex ?? this.currentIndex,
      categoryBreakdownJson:
          categoryBreakdownJson ?? this.categoryBreakdownJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (questionIdsJson.present) {
      map['question_ids_json'] = Variable<String>(questionIdsJson.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (flagsJson.present) {
      map['flags_json'] = Variable<String>(flagsJson.value);
    }
    if (optionOrderJson.present) {
      map['option_order_json'] = Variable<String>(optionOrderJson.value);
    }
    if (currentIndex.present) {
      map['current_index'] = Variable<int>(currentIndex.value);
    }
    if (categoryBreakdownJson.present) {
      map['category_breakdown_json'] = Variable<String>(
        categoryBreakdownJson.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MockExamsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('deadline: $deadline, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('percentage: $percentage, ')
          ..write('result: $result, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('flagsJson: $flagsJson, ')
          ..write('optionOrderJson: $optionOrderJson, ')
          ..write('currentIndex: $currentIndex, ')
          ..write('categoryBreakdownJson: $categoryBreakdownJson')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES questions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, questionId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final String questionId;
  final DateTime createdAt;
  const Bookmark({
    required this.id,
    required this.questionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      questionId: Value(questionId),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({int? id, String? questionId, DateTime? createdAt}) =>
      Bookmark(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        createdAt: createdAt ?? this.createdAt,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    required DateTime createdAt,
  }) : questionId = Value(questionId),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<String>? questionId,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeakConceptsTable extends WeakConcepts
    with TableInfo<$WeakConceptsTable, WeakConcept> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeakConceptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _conceptNameMeta = const VerificationMeta(
    'conceptName',
  );
  @override
  late final GeneratedColumn<String> conceptName = GeneratedColumn<String>(
    'concept_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _errorCountMeta = const VerificationMeta(
    'errorCount',
  );
  @override
  late final GeneratedColumn<int> errorCount = GeneratedColumn<int>(
    'error_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctStreakMeta = const VerificationMeta(
    'correctStreak',
  );
  @override
  late final GeneratedColumn<int> correctStreak = GeneratedColumn<int>(
    'correct_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastMissedAtMeta = const VerificationMeta(
    'lastMissedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMissedAt = GeneratedColumn<DateTime>(
    'last_missed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _masteryStatusMeta = const VerificationMeta(
    'masteryStatus',
  );
  @override
  late final GeneratedColumn<String> masteryStatus = GeneratedColumn<String>(
    'mastery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('weak'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conceptName,
    categoryId,
    errorCount,
    correctStreak,
    lastMissedAt,
    masteryStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weak_concepts';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeakConcept> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('concept_name')) {
      context.handle(
        _conceptNameMeta,
        conceptName.isAcceptableOrUnknown(
          data['concept_name']!,
          _conceptNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conceptNameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('error_count')) {
      context.handle(
        _errorCountMeta,
        errorCount.isAcceptableOrUnknown(data['error_count']!, _errorCountMeta),
      );
    }
    if (data.containsKey('correct_streak')) {
      context.handle(
        _correctStreakMeta,
        correctStreak.isAcceptableOrUnknown(
          data['correct_streak']!,
          _correctStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_missed_at')) {
      context.handle(
        _lastMissedAtMeta,
        lastMissedAt.isAcceptableOrUnknown(
          data['last_missed_at']!,
          _lastMissedAtMeta,
        ),
      );
    }
    if (data.containsKey('mastery_status')) {
      context.handle(
        _masteryStatusMeta,
        masteryStatus.isAcceptableOrUnknown(
          data['mastery_status']!,
          _masteryStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {categoryId, conceptName},
  ];
  @override
  WeakConcept map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeakConcept(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      conceptName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concept_name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      errorCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}error_count'],
      )!,
      correctStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_streak'],
      )!,
      lastMissedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_missed_at'],
      ),
      masteryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_status'],
      )!,
    );
  }

  @override
  $WeakConceptsTable createAlias(String alias) {
    return $WeakConceptsTable(attachedDatabase, alias);
  }
}

class WeakConcept extends DataClass implements Insertable<WeakConcept> {
  final int id;
  final String conceptName;
  final String categoryId;
  final int errorCount;
  final int correctStreak;
  final DateTime? lastMissedAt;

  /// weak | improving | mastered
  final String masteryStatus;
  const WeakConcept({
    required this.id,
    required this.conceptName,
    required this.categoryId,
    required this.errorCount,
    required this.correctStreak,
    this.lastMissedAt,
    required this.masteryStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['concept_name'] = Variable<String>(conceptName);
    map['category_id'] = Variable<String>(categoryId);
    map['error_count'] = Variable<int>(errorCount);
    map['correct_streak'] = Variable<int>(correctStreak);
    if (!nullToAbsent || lastMissedAt != null) {
      map['last_missed_at'] = Variable<DateTime>(lastMissedAt);
    }
    map['mastery_status'] = Variable<String>(masteryStatus);
    return map;
  }

  WeakConceptsCompanion toCompanion(bool nullToAbsent) {
    return WeakConceptsCompanion(
      id: Value(id),
      conceptName: Value(conceptName),
      categoryId: Value(categoryId),
      errorCount: Value(errorCount),
      correctStreak: Value(correctStreak),
      lastMissedAt: lastMissedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMissedAt),
      masteryStatus: Value(masteryStatus),
    );
  }

  factory WeakConcept.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeakConcept(
      id: serializer.fromJson<int>(json['id']),
      conceptName: serializer.fromJson<String>(json['conceptName']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      errorCount: serializer.fromJson<int>(json['errorCount']),
      correctStreak: serializer.fromJson<int>(json['correctStreak']),
      lastMissedAt: serializer.fromJson<DateTime?>(json['lastMissedAt']),
      masteryStatus: serializer.fromJson<String>(json['masteryStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conceptName': serializer.toJson<String>(conceptName),
      'categoryId': serializer.toJson<String>(categoryId),
      'errorCount': serializer.toJson<int>(errorCount),
      'correctStreak': serializer.toJson<int>(correctStreak),
      'lastMissedAt': serializer.toJson<DateTime?>(lastMissedAt),
      'masteryStatus': serializer.toJson<String>(masteryStatus),
    };
  }

  WeakConcept copyWith({
    int? id,
    String? conceptName,
    String? categoryId,
    int? errorCount,
    int? correctStreak,
    Value<DateTime?> lastMissedAt = const Value.absent(),
    String? masteryStatus,
  }) => WeakConcept(
    id: id ?? this.id,
    conceptName: conceptName ?? this.conceptName,
    categoryId: categoryId ?? this.categoryId,
    errorCount: errorCount ?? this.errorCount,
    correctStreak: correctStreak ?? this.correctStreak,
    lastMissedAt: lastMissedAt.present ? lastMissedAt.value : this.lastMissedAt,
    masteryStatus: masteryStatus ?? this.masteryStatus,
  );
  WeakConcept copyWithCompanion(WeakConceptsCompanion data) {
    return WeakConcept(
      id: data.id.present ? data.id.value : this.id,
      conceptName: data.conceptName.present
          ? data.conceptName.value
          : this.conceptName,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      errorCount: data.errorCount.present
          ? data.errorCount.value
          : this.errorCount,
      correctStreak: data.correctStreak.present
          ? data.correctStreak.value
          : this.correctStreak,
      lastMissedAt: data.lastMissedAt.present
          ? data.lastMissedAt.value
          : this.lastMissedAt,
      masteryStatus: data.masteryStatus.present
          ? data.masteryStatus.value
          : this.masteryStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeakConcept(')
          ..write('id: $id, ')
          ..write('conceptName: $conceptName, ')
          ..write('categoryId: $categoryId, ')
          ..write('errorCount: $errorCount, ')
          ..write('correctStreak: $correctStreak, ')
          ..write('lastMissedAt: $lastMissedAt, ')
          ..write('masteryStatus: $masteryStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conceptName,
    categoryId,
    errorCount,
    correctStreak,
    lastMissedAt,
    masteryStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeakConcept &&
          other.id == this.id &&
          other.conceptName == this.conceptName &&
          other.categoryId == this.categoryId &&
          other.errorCount == this.errorCount &&
          other.correctStreak == this.correctStreak &&
          other.lastMissedAt == this.lastMissedAt &&
          other.masteryStatus == this.masteryStatus);
}

class WeakConceptsCompanion extends UpdateCompanion<WeakConcept> {
  final Value<int> id;
  final Value<String> conceptName;
  final Value<String> categoryId;
  final Value<int> errorCount;
  final Value<int> correctStreak;
  final Value<DateTime?> lastMissedAt;
  final Value<String> masteryStatus;
  const WeakConceptsCompanion({
    this.id = const Value.absent(),
    this.conceptName = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.correctStreak = const Value.absent(),
    this.lastMissedAt = const Value.absent(),
    this.masteryStatus = const Value.absent(),
  });
  WeakConceptsCompanion.insert({
    this.id = const Value.absent(),
    required String conceptName,
    required String categoryId,
    this.errorCount = const Value.absent(),
    this.correctStreak = const Value.absent(),
    this.lastMissedAt = const Value.absent(),
    this.masteryStatus = const Value.absent(),
  }) : conceptName = Value(conceptName),
       categoryId = Value(categoryId);
  static Insertable<WeakConcept> custom({
    Expression<int>? id,
    Expression<String>? conceptName,
    Expression<String>? categoryId,
    Expression<int>? errorCount,
    Expression<int>? correctStreak,
    Expression<DateTime>? lastMissedAt,
    Expression<String>? masteryStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conceptName != null) 'concept_name': conceptName,
      if (categoryId != null) 'category_id': categoryId,
      if (errorCount != null) 'error_count': errorCount,
      if (correctStreak != null) 'correct_streak': correctStreak,
      if (lastMissedAt != null) 'last_missed_at': lastMissedAt,
      if (masteryStatus != null) 'mastery_status': masteryStatus,
    });
  }

  WeakConceptsCompanion copyWith({
    Value<int>? id,
    Value<String>? conceptName,
    Value<String>? categoryId,
    Value<int>? errorCount,
    Value<int>? correctStreak,
    Value<DateTime?>? lastMissedAt,
    Value<String>? masteryStatus,
  }) {
    return WeakConceptsCompanion(
      id: id ?? this.id,
      conceptName: conceptName ?? this.conceptName,
      categoryId: categoryId ?? this.categoryId,
      errorCount: errorCount ?? this.errorCount,
      correctStreak: correctStreak ?? this.correctStreak,
      lastMissedAt: lastMissedAt ?? this.lastMissedAt,
      masteryStatus: masteryStatus ?? this.masteryStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conceptName.present) {
      map['concept_name'] = Variable<String>(conceptName.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (errorCount.present) {
      map['error_count'] = Variable<int>(errorCount.value);
    }
    if (correctStreak.present) {
      map['correct_streak'] = Variable<int>(correctStreak.value);
    }
    if (lastMissedAt.present) {
      map['last_missed_at'] = Variable<DateTime>(lastMissedAt.value);
    }
    if (masteryStatus.present) {
      map['mastery_status'] = Variable<String>(masteryStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeakConceptsCompanion(')
          ..write('id: $id, ')
          ..write('conceptName: $conceptName, ')
          ..write('categoryId: $categoryId, ')
          ..write('errorCount: $errorCount, ')
          ..write('correctStreak: $correctStreak, ')
          ..write('lastMissedAt: $lastMissedAt, ')
          ..write('masteryStatus: $masteryStatus')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaData extends DataClass implements Insertable<AppMetaData> {
  final String key;
  final String value;
  const AppMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaData copyWith({String? key, String? value}) =>
      AppMetaData(key: key ?? this.key, value: value ?? this.value);
  AppMetaData copyWithCompanion(AppMetaCompanion data) {
    return AppMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $UserAnswersTable userAnswers = $UserAnswersTable(this);
  late final $LearningRoundsTable learningRounds = $LearningRoundsTable(this);
  late final $CategoryProgressTable categoryProgress = $CategoryProgressTable(
    this,
  );
  late final $MockExamsTable mockExams = $MockExamsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $WeakConceptsTable weakConcepts = $WeakConceptsTable(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  late final Index idxQuestionsCategory = Index(
    'idx_questions_category',
    'CREATE INDEX idx_questions_category ON questions (category_id)',
  );
  late final Index idxQuestionsConcept = Index(
    'idx_questions_concept',
    'CREATE INDEX idx_questions_concept ON questions (category_id, technical_concept)',
  );
  late final Index idxAnswersQuestion = Index(
    'idx_answers_question',
    'CREATE INDEX idx_answers_question ON user_answers (question_id)',
  );
  late final Index idxAnswersTime = Index(
    'idx_answers_time',
    'CREATE INDEX idx_answers_time ON user_answers (answered_at)',
  );
  late final Index idxRoundsCategory = Index(
    'idx_rounds_category',
    'CREATE INDEX idx_rounds_category ON learning_rounds (category_id, status)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    questions,
    userAnswers,
    learningRounds,
    categoryProgress,
    mockExams,
    bookmarks,
    weakConcepts,
    appMeta,
    idxQuestionsCategory,
    idxQuestionsConcept,
    idxAnswersQuestion,
    idxAnswersTime,
    idxRoundsCategory,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_answers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'questions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookmarks', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      required String description,
      required int totalQuestions,
      required int sortOrder,
      required int weight,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<int> totalQuestions,
      Value<int> sortOrder,
      Value<int> weight,
      Value<int> rowid,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuestionsTable, List<QuestionRow>>
  _questionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questions,
    aliasName: 'categories__id__questions__category_id',
  );

  $$QuestionsTableProcessedTableManager get questionsRefs {
    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearningRoundsTable, List<LearningRound>>
  _learningRoundsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.learningRounds,
    aliasName: 'categories__id__learning_rounds__category_id',
  );

  $$LearningRoundsTableProcessedTableManager get learningRoundsRefs {
    final manager = $$LearningRoundsTableTableManager(
      $_db,
      $_db.learningRounds,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_learningRoundsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CategoryProgressTable, List<CategoryProgressData>>
  _categoryProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categoryProgress,
    aliasName: 'categories__id__category_progress__category_id',
  );

  $$CategoryProgressTableProcessedTableManager get categoryProgressRefs {
    final manager = $$CategoryProgressTableTableManager(
      $_db,
      $_db.categoryProgress,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeakConceptsTable, List<WeakConcept>>
  _weakConceptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weakConcepts,
    aliasName: 'categories__id__weak_concepts__category_id',
  );

  $$WeakConceptsTableProcessedTableManager get weakConceptsRefs {
    final manager = $$WeakConceptsTableTableManager(
      $_db,
      $_db.weakConcepts,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weakConceptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> questionsRefs(
    Expression<bool> Function($$QuestionsTableFilterComposer f) f,
  ) {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learningRoundsRefs(
    Expression<bool> Function($$LearningRoundsTableFilterComposer f) f,
  ) {
    final $$LearningRoundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningRounds,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningRoundsTableFilterComposer(
            $db: $db,
            $table: $db.learningRounds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoryProgressRefs(
    Expression<bool> Function($$CategoryProgressTableFilterComposer f) f,
  ) {
    final $$CategoryProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProgress,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProgressTableFilterComposer(
            $db: $db,
            $table: $db.categoryProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weakConceptsRefs(
    Expression<bool> Function($$WeakConceptsTableFilterComposer f) f,
  ) {
    final $$WeakConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weakConcepts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeakConceptsTableFilterComposer(
            $db: $db,
            $table: $db.weakConcepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  Expression<T> questionsRefs<T extends Object>(
    Expression<T> Function($$QuestionsTableAnnotationComposer a) f,
  ) {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> learningRoundsRefs<T extends Object>(
    Expression<T> Function($$LearningRoundsTableAnnotationComposer a) f,
  ) {
    final $$LearningRoundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningRounds,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningRoundsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningRounds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoryProgressRefs<T extends Object>(
    Expression<T> Function($$CategoryProgressTableAnnotationComposer a) f,
  ) {
    final $$CategoryProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProgress,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weakConceptsRefs<T extends Object>(
    Expression<T> Function($$WeakConceptsTableAnnotationComposer a) f,
  ) {
    final $$WeakConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weakConcepts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeakConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.weakConcepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({
            bool questionsRefs,
            bool learningRoundsRefs,
            bool categoryProgressRefs,
            bool weakConceptsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                description: description,
                totalQuestions: totalQuestions,
                sortOrder: sortOrder,
                weight: weight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required int totalQuestions,
                required int sortOrder,
                required int weight,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
                totalQuestions: totalQuestions,
                sortOrder: sortOrder,
                weight: weight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                questionsRefs = false,
                learningRoundsRefs = false,
                categoryProgressRefs = false,
                weakConceptsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (questionsRefs) db.questions,
                    if (learningRoundsRefs) db.learningRounds,
                    if (categoryProgressRefs) db.categoryProgress,
                    if (weakConceptsRefs) db.weakConcepts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (questionsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          QuestionRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._questionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).questionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learningRoundsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          LearningRound
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._learningRoundsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).learningRoundsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoryProgressRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          CategoryProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._categoryProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).categoryProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weakConceptsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          WeakConcept
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._weakConceptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).weakConceptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({
        bool questionsRefs,
        bool learningRoundsRefs,
        bool categoryProgressRefs,
        bool weakConceptsRefs,
      })
    >;
typedef $$QuestionsTableCreateCompanionBuilder =
    QuestionsCompanion Function({
      required String id,
      required String categoryId,
      required String subcategory,
      required String questionType,
      required String questionStyle,
      required int difficulty,
      required String component,
      required String questionText,
      required String optionsJson,
      required String correctAnswersJson,
      required String explanation,
      required String incorrectOptionExplanationsJson,
      required String scenario,
      required String examTip,
      required String technicalConcept,
      required String documentationReference,
      required String versionApplicability,
      Value<int> rowid,
    });
typedef $$QuestionsTableUpdateCompanionBuilder =
    QuestionsCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<String> subcategory,
      Value<String> questionType,
      Value<String> questionStyle,
      Value<int> difficulty,
      Value<String> component,
      Value<String> questionText,
      Value<String> optionsJson,
      Value<String> correctAnswersJson,
      Value<String> explanation,
      Value<String> incorrectOptionExplanationsJson,
      Value<String> scenario,
      Value<String> examTip,
      Value<String> technicalConcept,
      Value<String> documentationReference,
      Value<String> versionApplicability,
      Value<int> rowid,
    });

final class $$QuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionsTable, QuestionRow> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('questions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$UserAnswersTable, List<UserAnswer>>
  _userAnswersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAnswers,
    aliasName: 'questions__id__user_answers__question_id',
  );

  $$UserAnswersTableProcessedTableManager get userAnswersRefs {
    final manager = $$UserAnswersTableTableManager(
      $_db,
      $_db.userAnswers,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAnswersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: 'questions__id__bookmarks__question_id',
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionStyle => $composableBuilder(
    column: $table.questionStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctAnswersJson => $composableBuilder(
    column: $table.correctAnswersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incorrectOptionExplanationsJson =>
      $composableBuilder(
        column: $table.incorrectOptionExplanationsJson,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get scenario => $composableBuilder(
    column: $table.scenario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examTip => $composableBuilder(
    column: $table.examTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicalConcept => $composableBuilder(
    column: $table.technicalConcept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentationReference => $composableBuilder(
    column: $table.documentationReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get versionApplicability => $composableBuilder(
    column: $table.versionApplicability,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> userAnswersRefs(
    Expression<bool> Function($$UserAnswersTableFilterComposer f) f,
  ) {
    final $$UserAnswersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAnswers,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableFilterComposer(
            $db: $db,
            $table: $db.userAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionStyle => $composableBuilder(
    column: $table.questionStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctAnswersJson => $composableBuilder(
    column: $table.correctAnswersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incorrectOptionExplanationsJson =>
      $composableBuilder(
        column: $table.incorrectOptionExplanationsJson,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get scenario => $composableBuilder(
    column: $table.scenario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examTip => $composableBuilder(
    column: $table.examTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicalConcept => $composableBuilder(
    column: $table.technicalConcept,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentationReference => $composableBuilder(
    column: $table.documentationReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get versionApplicability => $composableBuilder(
    column: $table.versionApplicability,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionStyle => $composableBuilder(
    column: $table.questionStyle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get component =>
      $composableBuilder(column: $table.component, builder: (column) => column);

  GeneratedColumn<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correctAnswersJson => $composableBuilder(
    column: $table.correctAnswersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get incorrectOptionExplanationsJson =>
      $composableBuilder(
        column: $table.incorrectOptionExplanationsJson,
        builder: (column) => column,
      );

  GeneratedColumn<String> get scenario =>
      $composableBuilder(column: $table.scenario, builder: (column) => column);

  GeneratedColumn<String> get examTip =>
      $composableBuilder(column: $table.examTip, builder: (column) => column);

  GeneratedColumn<String> get technicalConcept => $composableBuilder(
    column: $table.technicalConcept,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentationReference => $composableBuilder(
    column: $table.documentationReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get versionApplicability => $composableBuilder(
    column: $table.versionApplicability,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> userAnswersRefs<T extends Object>(
    Expression<T> Function($$UserAnswersTableAnnotationComposer a) f,
  ) {
    final $$UserAnswersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAnswers,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableAnnotationComposer(
            $db: $db,
            $table: $db.userAnswers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.questionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTable,
          QuestionRow,
          $$QuestionsTableFilterComposer,
          $$QuestionsTableOrderingComposer,
          $$QuestionsTableAnnotationComposer,
          $$QuestionsTableCreateCompanionBuilder,
          $$QuestionsTableUpdateCompanionBuilder,
          (QuestionRow, $$QuestionsTableReferences),
          QuestionRow,
          PrefetchHooks Function({
            bool categoryId,
            bool userAnswersRefs,
            bool bookmarksRefs,
          })
        > {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> subcategory = const Value.absent(),
                Value<String> questionType = const Value.absent(),
                Value<String> questionStyle = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<String> component = const Value.absent(),
                Value<String> questionText = const Value.absent(),
                Value<String> optionsJson = const Value.absent(),
                Value<String> correctAnswersJson = const Value.absent(),
                Value<String> explanation = const Value.absent(),
                Value<String> incorrectOptionExplanationsJson =
                    const Value.absent(),
                Value<String> scenario = const Value.absent(),
                Value<String> examTip = const Value.absent(),
                Value<String> technicalConcept = const Value.absent(),
                Value<String> documentationReference = const Value.absent(),
                Value<String> versionApplicability = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion(
                id: id,
                categoryId: categoryId,
                subcategory: subcategory,
                questionType: questionType,
                questionStyle: questionStyle,
                difficulty: difficulty,
                component: component,
                questionText: questionText,
                optionsJson: optionsJson,
                correctAnswersJson: correctAnswersJson,
                explanation: explanation,
                incorrectOptionExplanationsJson:
                    incorrectOptionExplanationsJson,
                scenario: scenario,
                examTip: examTip,
                technicalConcept: technicalConcept,
                documentationReference: documentationReference,
                versionApplicability: versionApplicability,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String subcategory,
                required String questionType,
                required String questionStyle,
                required int difficulty,
                required String component,
                required String questionText,
                required String optionsJson,
                required String correctAnswersJson,
                required String explanation,
                required String incorrectOptionExplanationsJson,
                required String scenario,
                required String examTip,
                required String technicalConcept,
                required String documentationReference,
                required String versionApplicability,
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion.insert(
                id: id,
                categoryId: categoryId,
                subcategory: subcategory,
                questionType: questionType,
                questionStyle: questionStyle,
                difficulty: difficulty,
                component: component,
                questionText: questionText,
                optionsJson: optionsJson,
                correctAnswersJson: correctAnswersJson,
                explanation: explanation,
                incorrectOptionExplanationsJson:
                    incorrectOptionExplanationsJson,
                scenario: scenario,
                examTip: examTip,
                technicalConcept: technicalConcept,
                documentationReference: documentationReference,
                versionApplicability: versionApplicability,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                userAnswersRefs = false,
                bookmarksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userAnswersRefs) db.userAnswers,
                    if (bookmarksRefs) db.bookmarks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$QuestionsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$QuestionsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userAnswersRefs)
                        await $_getPrefetchedData<
                          QuestionRow,
                          $QuestionsTable,
                          UserAnswer
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._userAnswersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).userAnswersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookmarksRefs)
                        await $_getPrefetchedData<
                          QuestionRow,
                          $QuestionsTable,
                          Bookmark
                        >(
                          currentTable: table,
                          referencedTable: $$QuestionsTableReferences
                              ._bookmarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuestionsTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.questionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTable,
      QuestionRow,
      $$QuestionsTableFilterComposer,
      $$QuestionsTableOrderingComposer,
      $$QuestionsTableAnnotationComposer,
      $$QuestionsTableCreateCompanionBuilder,
      $$QuestionsTableUpdateCompanionBuilder,
      (QuestionRow, $$QuestionsTableReferences),
      QuestionRow,
      PrefetchHooks Function({
        bool categoryId,
        bool userAnswersRefs,
        bool bookmarksRefs,
      })
    >;
typedef $$UserAnswersTableCreateCompanionBuilder =
    UserAnswersCompanion Function({
      Value<int> id,
      required String questionId,
      required String selectedAnswersJson,
      required bool isCorrect,
      required int attemptNumber,
      required String source,
      required DateTime answeredAt,
    });
typedef $$UserAnswersTableUpdateCompanionBuilder =
    UserAnswersCompanion Function({
      Value<int> id,
      Value<String> questionId,
      Value<String> selectedAnswersJson,
      Value<bool> isCorrect,
      Value<int> attemptNumber,
      Value<String> source,
      Value<DateTime> answeredAt,
    });

final class $$UserAnswersTableReferences
    extends BaseReferences<_$AppDatabase, $UserAnswersTable, UserAnswer> {
  $$UserAnswersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('user_answers__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $UserAnswersTable> {
  $$UserAnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedAnswersJson => $composableBuilder(
    column: $table.selectedAnswersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAnswersTable> {
  $$UserAnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedAnswersJson => $composableBuilder(
    column: $table.selectedAnswersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAnswersTable> {
  $$UserAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get selectedAnswersJson => $composableBuilder(
    column: $table.selectedAnswersJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAnswersTable,
          UserAnswer,
          $$UserAnswersTableFilterComposer,
          $$UserAnswersTableOrderingComposer,
          $$UserAnswersTableAnnotationComposer,
          $$UserAnswersTableCreateCompanionBuilder,
          $$UserAnswersTableUpdateCompanionBuilder,
          (UserAnswer, $$UserAnswersTableReferences),
          UserAnswer,
          PrefetchHooks Function({bool questionId})
        > {
  $$UserAnswersTableTableManager(_$AppDatabase db, $UserAnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> selectedAnswersJson = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> attemptNumber = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
              }) => UserAnswersCompanion(
                id: id,
                questionId: questionId,
                selectedAnswersJson: selectedAnswersJson,
                isCorrect: isCorrect,
                attemptNumber: attemptNumber,
                source: source,
                answeredAt: answeredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String questionId,
                required String selectedAnswersJson,
                required bool isCorrect,
                required int attemptNumber,
                required String source,
                required DateTime answeredAt,
              }) => UserAnswersCompanion.insert(
                id: id,
                questionId: questionId,
                selectedAnswersJson: selectedAnswersJson,
                isCorrect: isCorrect,
                attemptNumber: attemptNumber,
                source: source,
                answeredAt: answeredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserAnswersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionId,
                                referencedTable: $$UserAnswersTableReferences
                                    ._questionIdTable(db),
                                referencedColumn: $$UserAnswersTableReferences
                                    ._questionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAnswersTable,
      UserAnswer,
      $$UserAnswersTableFilterComposer,
      $$UserAnswersTableOrderingComposer,
      $$UserAnswersTableAnnotationComposer,
      $$UserAnswersTableCreateCompanionBuilder,
      $$UserAnswersTableUpdateCompanionBuilder,
      (UserAnswer, $$UserAnswersTableReferences),
      UserAnswer,
      PrefetchHooks Function({bool questionId})
    >;
typedef $$LearningRoundsTableCreateCompanionBuilder =
    LearningRoundsCompanion Function({
      Value<int> id,
      Value<String?> categoryId,
      required String mode,
      required int roundNumber,
      required String questionIdsJson,
      Value<String> answersJson,
      Value<String> optionOrderJson,
      Value<int> currentIndex,
      Value<int?> score,
      required String status,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
    });
typedef $$LearningRoundsTableUpdateCompanionBuilder =
    LearningRoundsCompanion Function({
      Value<int> id,
      Value<String?> categoryId,
      Value<String> mode,
      Value<int> roundNumber,
      Value<String> questionIdsJson,
      Value<String> answersJson,
      Value<String> optionOrderJson,
      Value<int> currentIndex,
      Value<int?> score,
      Value<String> status,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
    });

final class $$LearningRoundsTableReferences
    extends BaseReferences<_$AppDatabase, $LearningRoundsTable, LearningRound> {
  $$LearningRoundsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('learning_rounds__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningRoundsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningRoundsTable> {
  $$LearningRoundsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningRoundsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningRoundsTable> {
  $$LearningRoundsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningRoundsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningRoundsTable> {
  $$LearningRoundsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningRoundsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningRoundsTable,
          LearningRound,
          $$LearningRoundsTableFilterComposer,
          $$LearningRoundsTableOrderingComposer,
          $$LearningRoundsTableAnnotationComposer,
          $$LearningRoundsTableCreateCompanionBuilder,
          $$LearningRoundsTableUpdateCompanionBuilder,
          (LearningRound, $$LearningRoundsTableReferences),
          LearningRound,
          PrefetchHooks Function({bool categoryId})
        > {
  $$LearningRoundsTableTableManager(
    _$AppDatabase db,
    $LearningRoundsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningRoundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningRoundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningRoundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int> roundNumber = const Value.absent(),
                Value<String> questionIdsJson = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<String> optionOrderJson = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<int?> score = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => LearningRoundsCompanion(
                id: id,
                categoryId: categoryId,
                mode: mode,
                roundNumber: roundNumber,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                optionOrderJson: optionOrderJson,
                currentIndex: currentIndex,
                score: score,
                status: status,
                startedAt: startedAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                required String mode,
                required int roundNumber,
                required String questionIdsJson,
                Value<String> answersJson = const Value.absent(),
                Value<String> optionOrderJson = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<int?> score = const Value.absent(),
                required String status,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
              }) => LearningRoundsCompanion.insert(
                id: id,
                categoryId: categoryId,
                mode: mode,
                roundNumber: roundNumber,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                optionOrderJson: optionOrderJson,
                currentIndex: currentIndex,
                score: score,
                status: status,
                startedAt: startedAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LearningRoundsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$LearningRoundsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn:
                                    $$LearningRoundsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LearningRoundsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningRoundsTable,
      LearningRound,
      $$LearningRoundsTableFilterComposer,
      $$LearningRoundsTableOrderingComposer,
      $$LearningRoundsTableAnnotationComposer,
      $$LearningRoundsTableCreateCompanionBuilder,
      $$LearningRoundsTableUpdateCompanionBuilder,
      (LearningRound, $$LearningRoundsTableReferences),
      LearningRound,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$CategoryProgressTableCreateCompanionBuilder =
    CategoryProgressCompanion Function({
      Value<int> id,
      required String categoryId,
      Value<int> questionsCovered,
      Value<int> roundsPassed,
      Value<int> roundsFailed,
      Value<double> completionPercentage,
      Value<String> masteryStatus,
      Value<String> coveredQuestionIdsJson,
    });
typedef $$CategoryProgressTableUpdateCompanionBuilder =
    CategoryProgressCompanion Function({
      Value<int> id,
      Value<String> categoryId,
      Value<int> questionsCovered,
      Value<int> roundsPassed,
      Value<int> roundsFailed,
      Value<double> completionPercentage,
      Value<String> masteryStatus,
      Value<String> coveredQuestionIdsJson,
    });

final class $$CategoryProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CategoryProgressTable,
          CategoryProgressData
        > {
  $$CategoryProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('category_progress__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CategoryProgressTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryProgressTable> {
  $$CategoryProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionsCovered => $composableBuilder(
    column: $table.questionsCovered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundsPassed => $composableBuilder(
    column: $table.roundsPassed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundsFailed => $composableBuilder(
    column: $table.roundsFailed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coveredQuestionIdsJson => $composableBuilder(
    column: $table.coveredQuestionIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryProgressTable> {
  $$CategoryProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionsCovered => $composableBuilder(
    column: $table.questionsCovered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundsPassed => $composableBuilder(
    column: $table.roundsPassed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundsFailed => $composableBuilder(
    column: $table.roundsFailed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coveredQuestionIdsJson => $composableBuilder(
    column: $table.coveredQuestionIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryProgressTable> {
  $$CategoryProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get questionsCovered => $composableBuilder(
    column: $table.questionsCovered,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundsPassed => $composableBuilder(
    column: $table.roundsPassed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundsFailed => $composableBuilder(
    column: $table.roundsFailed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coveredQuestionIdsJson => $composableBuilder(
    column: $table.coveredQuestionIdsJson,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryProgressTable,
          CategoryProgressData,
          $$CategoryProgressTableFilterComposer,
          $$CategoryProgressTableOrderingComposer,
          $$CategoryProgressTableAnnotationComposer,
          $$CategoryProgressTableCreateCompanionBuilder,
          $$CategoryProgressTableUpdateCompanionBuilder,
          (CategoryProgressData, $$CategoryProgressTableReferences),
          CategoryProgressData,
          PrefetchHooks Function({bool categoryId})
        > {
  $$CategoryProgressTableTableManager(
    _$AppDatabase db,
    $CategoryProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> questionsCovered = const Value.absent(),
                Value<int> roundsPassed = const Value.absent(),
                Value<int> roundsFailed = const Value.absent(),
                Value<double> completionPercentage = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<String> coveredQuestionIdsJson = const Value.absent(),
              }) => CategoryProgressCompanion(
                id: id,
                categoryId: categoryId,
                questionsCovered: questionsCovered,
                roundsPassed: roundsPassed,
                roundsFailed: roundsFailed,
                completionPercentage: completionPercentage,
                masteryStatus: masteryStatus,
                coveredQuestionIdsJson: coveredQuestionIdsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String categoryId,
                Value<int> questionsCovered = const Value.absent(),
                Value<int> roundsPassed = const Value.absent(),
                Value<int> roundsFailed = const Value.absent(),
                Value<double> completionPercentage = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<String> coveredQuestionIdsJson = const Value.absent(),
              }) => CategoryProgressCompanion.insert(
                id: id,
                categoryId: categoryId,
                questionsCovered: questionsCovered,
                roundsPassed: roundsPassed,
                roundsFailed: roundsFailed,
                completionPercentage: completionPercentage,
                masteryStatus: masteryStatus,
                coveredQuestionIdsJson: coveredQuestionIdsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoryProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$CategoryProgressTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$CategoryProgressTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CategoryProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryProgressTable,
      CategoryProgressData,
      $$CategoryProgressTableFilterComposer,
      $$CategoryProgressTableOrderingComposer,
      $$CategoryProgressTableAnnotationComposer,
      $$CategoryProgressTableCreateCompanionBuilder,
      $$CategoryProgressTableUpdateCompanionBuilder,
      (CategoryProgressData, $$CategoryProgressTableReferences),
      CategoryProgressData,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$MockExamsTableCreateCompanionBuilder =
    MockExamsCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required DateTime deadline,
      Value<int?> durationSeconds,
      required int totalQuestions,
      Value<int?> correctAnswers,
      Value<double?> percentage,
      required String result,
      required String questionIdsJson,
      Value<String> answersJson,
      Value<String> flagsJson,
      Value<String> optionOrderJson,
      Value<int> currentIndex,
      Value<String?> categoryBreakdownJson,
    });
typedef $$MockExamsTableUpdateCompanionBuilder =
    MockExamsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> deadline,
      Value<int?> durationSeconds,
      Value<int> totalQuestions,
      Value<int?> correctAnswers,
      Value<double?> percentage,
      Value<String> result,
      Value<String> questionIdsJson,
      Value<String> answersJson,
      Value<String> flagsJson,
      Value<String> optionOrderJson,
      Value<int> currentIndex,
      Value<String?> categoryBreakdownJson,
    });

class $$MockExamsTableFilterComposer
    extends Composer<_$AppDatabase, $MockExamsTable> {
  $$MockExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagsJson => $composableBuilder(
    column: $table.flagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryBreakdownJson => $composableBuilder(
    column: $table.categoryBreakdownJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MockExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $MockExamsTable> {
  $$MockExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagsJson => $composableBuilder(
    column: $table.flagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryBreakdownJson => $composableBuilder(
    column: $table.categoryBreakdownJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MockExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MockExamsTable> {
  $$MockExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flagsJson =>
      $composableBuilder(column: $table.flagsJson, builder: (column) => column);

  GeneratedColumn<String> get optionOrderJson => $composableBuilder(
    column: $table.optionOrderJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentIndex => $composableBuilder(
    column: $table.currentIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryBreakdownJson => $composableBuilder(
    column: $table.categoryBreakdownJson,
    builder: (column) => column,
  );
}

class $$MockExamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MockExamsTable,
          MockExam,
          $$MockExamsTableFilterComposer,
          $$MockExamsTableOrderingComposer,
          $$MockExamsTableAnnotationComposer,
          $$MockExamsTableCreateCompanionBuilder,
          $$MockExamsTableUpdateCompanionBuilder,
          (MockExam, BaseReferences<_$AppDatabase, $MockExamsTable, MockExam>),
          MockExam,
          PrefetchHooks Function()
        > {
  $$MockExamsTableTableManager(_$AppDatabase db, $MockExamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MockExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MockExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MockExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<int?> correctAnswers = const Value.absent(),
                Value<double?> percentage = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String> questionIdsJson = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<String> flagsJson = const Value.absent(),
                Value<String> optionOrderJson = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<String?> categoryBreakdownJson = const Value.absent(),
              }) => MockExamsCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                deadline: deadline,
                durationSeconds: durationSeconds,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                percentage: percentage,
                result: result,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                flagsJson: flagsJson,
                optionOrderJson: optionOrderJson,
                currentIndex: currentIndex,
                categoryBreakdownJson: categoryBreakdownJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime deadline,
                Value<int?> durationSeconds = const Value.absent(),
                required int totalQuestions,
                Value<int?> correctAnswers = const Value.absent(),
                Value<double?> percentage = const Value.absent(),
                required String result,
                required String questionIdsJson,
                Value<String> answersJson = const Value.absent(),
                Value<String> flagsJson = const Value.absent(),
                Value<String> optionOrderJson = const Value.absent(),
                Value<int> currentIndex = const Value.absent(),
                Value<String?> categoryBreakdownJson = const Value.absent(),
              }) => MockExamsCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                deadline: deadline,
                durationSeconds: durationSeconds,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                percentage: percentage,
                result: result,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                flagsJson: flagsJson,
                optionOrderJson: optionOrderJson,
                currentIndex: currentIndex,
                categoryBreakdownJson: categoryBreakdownJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MockExamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MockExamsTable,
      MockExam,
      $$MockExamsTableFilterComposer,
      $$MockExamsTableOrderingComposer,
      $$MockExamsTableAnnotationComposer,
      $$MockExamsTableCreateCompanionBuilder,
      $$MockExamsTableUpdateCompanionBuilder,
      (MockExam, BaseReferences<_$AppDatabase, $MockExamsTable, MockExam>),
      MockExam,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required String questionId,
      required DateTime createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<String> questionId,
      Value<DateTime> createdAt,
    });

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('bookmarks__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager(
      $_db,
      $_db.questions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableFilterComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableOrderingComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.questionId,
      referencedTable: $db.questions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.questions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, $$BookmarksTableReferences),
          Bookmark,
          PrefetchHooks Function({bool questionId})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                questionId: questionId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String questionId,
                required DateTime createdAt,
              }) => BookmarksCompanion.insert(
                id: id,
                questionId: questionId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (questionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.questionId,
                                referencedTable: $$BookmarksTableReferences
                                    ._questionIdTable(db),
                                referencedColumn: $$BookmarksTableReferences
                                    ._questionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, $$BookmarksTableReferences),
      Bookmark,
      PrefetchHooks Function({bool questionId})
    >;
typedef $$WeakConceptsTableCreateCompanionBuilder =
    WeakConceptsCompanion Function({
      Value<int> id,
      required String conceptName,
      required String categoryId,
      Value<int> errorCount,
      Value<int> correctStreak,
      Value<DateTime?> lastMissedAt,
      Value<String> masteryStatus,
    });
typedef $$WeakConceptsTableUpdateCompanionBuilder =
    WeakConceptsCompanion Function({
      Value<int> id,
      Value<String> conceptName,
      Value<String> categoryId,
      Value<int> errorCount,
      Value<int> correctStreak,
      Value<DateTime?> lastMissedAt,
      Value<String> masteryStatus,
    });

final class $$WeakConceptsTableReferences
    extends BaseReferences<_$AppDatabase, $WeakConceptsTable, WeakConcept> {
  $$WeakConceptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('weak_concepts__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeakConceptsTableFilterComposer
    extends Composer<_$AppDatabase, $WeakConceptsTable> {
  $$WeakConceptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conceptName => $composableBuilder(
    column: $table.conceptName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctStreak => $composableBuilder(
    column: $table.correctStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMissedAt => $composableBuilder(
    column: $table.lastMissedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeakConceptsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeakConceptsTable> {
  $$WeakConceptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conceptName => $composableBuilder(
    column: $table.conceptName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctStreak => $composableBuilder(
    column: $table.correctStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMissedAt => $composableBuilder(
    column: $table.lastMissedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeakConceptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeakConceptsTable> {
  $$WeakConceptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conceptName => $composableBuilder(
    column: $table.conceptName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctStreak => $composableBuilder(
    column: $table.correctStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMissedAt => $composableBuilder(
    column: $table.lastMissedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeakConceptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeakConceptsTable,
          WeakConcept,
          $$WeakConceptsTableFilterComposer,
          $$WeakConceptsTableOrderingComposer,
          $$WeakConceptsTableAnnotationComposer,
          $$WeakConceptsTableCreateCompanionBuilder,
          $$WeakConceptsTableUpdateCompanionBuilder,
          (WeakConcept, $$WeakConceptsTableReferences),
          WeakConcept,
          PrefetchHooks Function({bool categoryId})
        > {
  $$WeakConceptsTableTableManager(_$AppDatabase db, $WeakConceptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeakConceptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeakConceptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeakConceptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> conceptName = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> errorCount = const Value.absent(),
                Value<int> correctStreak = const Value.absent(),
                Value<DateTime?> lastMissedAt = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
              }) => WeakConceptsCompanion(
                id: id,
                conceptName: conceptName,
                categoryId: categoryId,
                errorCount: errorCount,
                correctStreak: correctStreak,
                lastMissedAt: lastMissedAt,
                masteryStatus: masteryStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String conceptName,
                required String categoryId,
                Value<int> errorCount = const Value.absent(),
                Value<int> correctStreak = const Value.absent(),
                Value<DateTime?> lastMissedAt = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
              }) => WeakConceptsCompanion.insert(
                id: id,
                conceptName: conceptName,
                categoryId: categoryId,
                errorCount: errorCount,
                correctStreak: correctStreak,
                lastMissedAt: lastMissedAt,
                masteryStatus: masteryStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeakConceptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$WeakConceptsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$WeakConceptsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeakConceptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeakConceptsTable,
      WeakConcept,
      $$WeakConceptsTableFilterComposer,
      $$WeakConceptsTableOrderingComposer,
      $$WeakConceptsTableAnnotationComposer,
      $$WeakConceptsTableCreateCompanionBuilder,
      $$WeakConceptsTableUpdateCompanionBuilder,
      (WeakConcept, $$WeakConceptsTableReferences),
      WeakConcept,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$AppMetaTableCreateCompanionBuilder =
    AppMetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppMetaTableUpdateCompanionBuilder =
    AppMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaData,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaData,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>,
          ),
          AppMetaData,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaData,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaData, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>),
      AppMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$UserAnswersTableTableManager get userAnswers =>
      $$UserAnswersTableTableManager(_db, _db.userAnswers);
  $$LearningRoundsTableTableManager get learningRounds =>
      $$LearningRoundsTableTableManager(_db, _db.learningRounds);
  $$CategoryProgressTableTableManager get categoryProgress =>
      $$CategoryProgressTableTableManager(_db, _db.categoryProgress);
  $$MockExamsTableTableManager get mockExams =>
      $$MockExamsTableTableManager(_db, _db.mockExams);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$WeakConceptsTableTableManager get weakConcepts =>
      $$WeakConceptsTableTableManager(_db, _db.weakConcepts);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
}
