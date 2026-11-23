import 'package:cp4i_exam_prep/core/constants/app_constants.dart';
import 'package:cp4i_exam_prep/features/questions/domain/question.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final questions = testBank.questions;

  group('Question bank validation', () {
    test('contains at least 600 questions', () {
      expect(questions.length, greaterThanOrEqualTo(600));
    });

    test('every category meets its blueprint allocation', () {
      for (final c in kCategories) {
        final n = questions.where((q) => q.categoryId == c.id).length;
        expect(n, greaterThanOrEqualTo(c.targetQuestions), reason: c.id);
      }
    });

    test('IDs are unique and categories valid', () {
      expect(questions.map((q) => q.id).toSet().length, questions.length);
      final ids = kCategories.map((c) => c.id).toSet();
      expect(questions.every((q) => ids.contains(q.categoryId)), isTrue);
    });

    test('single-answer questions have exactly one correct answer; multi-select at least two and say so', () {
      for (final q in questions) {
        if (q.isMultiple) {
          expect(q.correctAnswers.length, greaterThanOrEqualTo(2), reason: q.id);
          expect(q.text, contains('(Select '), reason: q.id);
        } else {
          expect(q.correctAnswers.length, 1, reason: q.id);
          expect(q.text, isNot(contains('(Select ')), reason: q.id);
        }
      }
    });

    test('answer references are valid and options non-empty', () {
      for (final q in questions) {
        expect(q.options.length, greaterThanOrEqualTo(3), reason: q.id);
        expect(q.options.every((o) => o.trim().isNotEmpty), isTrue, reason: q.id);
        expect(q.options.map((o) => o.toLowerCase()).toSet().length, q.options.length, reason: '${q.id} duplicate option');
        expect(q.correctAnswers.every((i) => i >= 0 && i < q.options.length), isTrue, reason: q.id);
      }
    });

    test('every question has full explanation content', () {
      for (final q in questions) {
        expect(q.explanation.length, greaterThanOrEqualTo(100), reason: q.id);
        expect(q.optionRationales.length, q.options.length, reason: q.id);
        for (var i = 0; i < q.options.length; i++) {
          final expected = q.correctAnswers.contains(i) ? 'Correct' : 'Wrong';
          expect(q.optionRationales[i].startsWith(expected), isTrue, reason: '${q.id} rationale $i');
        }
        expect(q.scenario.trim(), isNotEmpty, reason: q.id);
        expect(q.examTip.trim(), isNotEmpty, reason: q.id);
        expect(q.documentationReference, startsWith('https://'), reason: q.id);
        expect(q.versionApplicability.trim(), isNotEmpty, reason: q.id);
      }
    });

    test('no duplicate question texts', () {
      String norm(String s) => s.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
      final seen = <String, String>{};
      for (final q in questions) {
        final key = norm(q.text);
        expect(seen.containsKey(key), isFalse, reason: '${q.id} duplicates ${seen[key]}');
        seen[key] = q.id;
      }
    });

    test('difficulty distribution is close to 20/35/35/10', () {
      double pct(Difficulty d) => questions.where((q) => q.difficulty == d).length * 100 / questions.length;
      expect(pct(Difficulty.beginner), closeTo(20, 3));
      expect(pct(Difficulty.intermediate), closeTo(35, 3));
      expect(pct(Difficulty.advanced), closeTo(35, 3));
      expect(pct(Difficulty.expert), closeTo(10, 3));
    });

    test('at least 60% of questions require practical reasoning', () {
      final practical = questions.where((q) => q.style != QuestionStyle.fundamental).length;
      expect(practical / questions.length, greaterThanOrEqualTo(0.6));
    });

    test('IDs are stable and prefixed by category', () {
      expect(testBank['OVR-001'].categoryId, 'ovr');
      expect(testBank['CPA-001'].categoryId, 'cpa');
      expect(testBank['OBS-001'].categoryId, 'obs');
    });
  });
}
