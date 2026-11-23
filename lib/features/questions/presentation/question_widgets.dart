import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/domain/learning_models.dart';
import '../../learning/presentation/progress_providers.dart';
import '../domain/question.dart';

/// Header chips shown above every question.
class QuestionMeta extends StatelessWidget {
  const QuestionMeta({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) => Wrap(spacing: 6, runSpacing: 6, children: [
        InfoChip(categoryById(question.categoryId).shortName, icon: Icons.folder_outlined),
        InfoChip(question.difficulty.label, icon: Icons.signal_cellular_alt, color: _difficultyColor(question.difficulty)),
        InfoChip(question.style.label, icon: Icons.category_outlined, color: Colors.blueGrey),
        if (question.isMultiple)
          InfoChip('Select ${question.requiredSelections}', icon: Icons.checklist, color: AppColors.warning),
      ]);

  static Color _difficultyColor(Difficulty d) => switch (d) {
        Difficulty.beginner => AppColors.correct,
        Difficulty.intermediate => AppColors.blue,
        Difficulty.advanced => Colors.deepOrange,
        Difficulty.expert => AppColors.incorrect,
      };
}

/// Bookmark toggle backed by the bookmark repository.
class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({super.key, required this.questionId});
  final String questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(bookmarkIdsProvider).value ?? const <String>[];
    final saved = ids.contains(questionId);
    return IconButton(
      tooltip: saved ? 'Remove bookmark' : 'Bookmark question',
      icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () async {
        await ref.read(bookmarkRepositoryProvider).toggle(questionId);
        ref.read(dataVersionProvider.notifier).bump();
      },
    );
  }
}

/// Answer options rendered as radio (single) or checkbox (multiple) tiles.
/// Never reveals the correct answer.
class AnswerOptions extends StatelessWidget {
  const AnswerOptions({
    super.key,
    required this.question,
    required this.order,
    required this.selected,
    required this.onToggle,
    this.enabled = true,
  });

  final Question question;

  /// Display position -> original option index.
  final List<int> order;
  final List<int> selected;
  final ValueChanged<int> onToggle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(children: [
      for (var pos = 0; pos < order.length; pos++)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _OptionTile(
            letter: optionLetter(pos),
            text: question.options[order[pos]],
            selected: selected.contains(order[pos]),
            multiple: question.isMultiple,
            enabled: enabled,
            scheme: scheme,
            onTap: () {
              HapticFeedback.selectionClick();
              onToggle(order[pos]);
            },
          ),
        ),
    ]);
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.letter,
    required this.text,
    required this.selected,
    required this.multiple,
    required this.enabled,
    required this.scheme,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final bool multiple;
  final bool enabled;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final border = selected ? scheme.primary : scheme.outlineVariant;
    return Semantics(
      selected: selected,
      button: true,
      label: 'Option $letter: $text',
      child: Material(
        color: selected ? scheme.primary.withValues(alpha: 0.10) : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: border, width: selected ? 2 : 1),
        ),
        child: InkWell(
          key: ValueKey('option-$letter'),
          borderRadius: BorderRadius.circular(12),
          onTap: enabled ? onTap : null,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  multiple
                      ? (selected ? Icons.check_box : Icons.check_box_outline_blank)
                      : (selected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                  color: selected ? scheme.primary : scheme.outline,
                ),
                const SizedBox(width: 10),
                Text('$letter. ', style: const TextStyle(fontWeight: FontWeight.w700)),
                Expanded(child: Text(text, style: const TextStyle(fontSize: 15.5, height: 1.35))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full teaching explanation for one answered question.
class ExplanationCard extends StatelessWidget {
  const ExplanationCard({super.key, required this.result, this.number, this.order, this.showUserAnswer = true});
  final QuestionResult result;

  /// False when revealing a question that was not answered (for example from bookmarks).
  final bool showUserAnswer;
  final int? number;

  /// Display order used when the question was answered (letters match what the user saw).
  final List<int>? order;

  @override
  Widget build(BuildContext context) {
    final q = result.question;
    final theme = Theme.of(context);
    final displayOrder = order ?? List.generate(q.options.length, (i) => i);
    String letterOf(int original) => optionLetter(displayOrder.indexOf(original));
    final statusColor = !showUserAnswer
        ? theme.colorScheme.primary
        : result.correct
            ? AppColors.correct
            : AppColors.incorrect;
    final selectedText = result.selected.isEmpty
        ? 'No answer'
        : (result.selected.toList()..sort((a, b) => displayOrder.indexOf(a).compareTo(displayOrder.indexOf(b))))
            .map((i) => '${letterOf(i)}. ${q.options[i]}')
            .join('\n');
    final correctText = ([...q.correctAnswers]..sort((a, b) => displayOrder.indexOf(a).compareTo(displayOrder.indexOf(b))))
        .map((i) => '${letterOf(i)}. ${q.options[i]}')
        .join('\n');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(!showUserAnswer ? Icons.menu_book : result.correct ? Icons.check_circle : Icons.cancel, color: statusColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${number != null ? 'Question $number · ' : ''}${!showUserAnswer ? 'Answer and explanation' : result.correct ? 'Correct' : 'Incorrect'}',
                style: theme.textTheme.titleMedium?.copyWith(color: statusColor, fontWeight: FontWeight.w700),
              ),
            ),
            BookmarkButton(questionId: q.id),
          ]),
          const SizedBox(height: 8),
          QuestionMeta(question: q),
          const SizedBox(height: 12),
          Text(q.text, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          if (showUserAnswer) _Block(title: 'Your answer', body: selectedText, color: statusColor),
          _Block(title: 'Correct answer', body: correctText, color: AppColors.correct),
          _Block(title: 'Explanation and technical background', body: q.explanation),
          _Heading('Why each option is right or wrong'),
          for (final original in displayOrder)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  q.correctAnswers.contains(original) ? Icons.check : Icons.close,
                  size: 18,
                  color: q.correctAnswers.contains(original) ? AppColors.correct : AppColors.incorrect,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: '${letterOf(original)}. ${q.options[original]}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: showUserAnswer && result.selected.contains(original) && !q.correctAnswers.contains(original)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    TextSpan(text: q.optionRationales[original]),
                  ])),
                ),
              ]),
            ),
          _Block(title: 'Enterprise scenario and architecture implications', body: q.scenario, icon: Icons.apartment),
          _Block(title: 'Exam tip and common mistakes', body: q.examTip, icon: Icons.lightbulb_outline, color: AppColors.warning),
          const Divider(height: 24),
          _KeyValue('Technical concept', q.technicalConcept),
          _KeyValue('IBM component', q.component),
          _KeyValue('Version applicability', q.versionApplicability),
          _KeyValue('Documentation', q.documentationReference, selectable: true),
          _KeyValue('Question ID', q.id),
        ]),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 6),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
      );
}

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.body, this.color, this.icon});
  final String title;
  final String body;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.07),
        border: Border(left: BorderSide(color: c, width: 3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          if (icon != null) ...[Icon(icon, size: 16, color: c), const SizedBox(width: 6)],
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: c))),
        ]),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(height: 1.4)),
      ]),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue(this.k, this.v, {this.selectable = false});
  final String k;
  final String v;
  final bool selectable;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 150, child: Text(k, style: Theme.of(context).textTheme.bodySmall)),
          Expanded(child: selectable ? SelectableText(v) : Text(v)),
        ]),
      );
}
