import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../practice/domain/practice_selector.dart';
import '../../questions/presentation/question_widgets.dart';
import 'learn_screens.dart';
import 'progress_providers.dart';
import 'session_controller.dart';

/// Five-question learning / practice round: one question at a time, Previous/Next, Submit.
class RoundScreen extends ConsumerWidget {
  const RoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionControllerProvider);
    return AsyncValueView(
      value: sessionAsync,
      builder: (s) {
        if (s == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Round')),
            body: EmptyState(
              icon: Icons.inbox_outlined,
              title: 'No round in progress',
              action: FilledButton(onPressed: () => context.go('/learn'), child: const Text('Go to Learn')),
            ),
          );
        }
        final q = s.current;
        final controller = ref.read(sessionControllerProvider.notifier);
        final title = s.isLearning
            ? '${categoryById(s.round.categoryId!).shortName} · Round ${s.round.roundNumber}'
            : PracticeMode.fromCode(s.round.mode)?.title ?? 'Practice';
        return Scaffold(
          appBar: AppBar(
            title: Text(title, overflow: TextOverflow.ellipsis),
            actions: [BookmarkButton(questionId: q.id)],
          ),
          body: SafeArea(
            child: ResponsiveBody(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(children: [
                    Text('Question ${s.index + 1}/${s.questions.length}',
                        key: const Key('progress-label'), style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Text('${s.answeredCount}/${s.questions.length} answered'),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    for (var i = 0; i < s.questions.length; i++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.goTo(i),
                          child: Container(
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: i == s.index
                                  ? Theme.of(context).colorScheme.primary
                                  : s.isComplete(s.questions[i])
                                      ? AppColors.blueLight
                                      : Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                        ),
                      ),
                  ]),
                ),
                Expanded(
                  child: ListView(padding: const EdgeInsets.all(16), children: [
                    QuestionMeta(question: q),
                    const SizedBox(height: 12),
                    Text(q.text, style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.4)),
                    if (q.isMultiple)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Select ${q.requiredSelections} answers. All must be correct.',
                            style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w600)),
                      ),
                    const SizedBox(height: 16),
                    AnswerOptions(
                      question: q,
                      order: s.orderFor(q),
                      selected: s.selectionFor(q.id),
                      onToggle: (original) => controller.toggleOption(q.id, original),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        key: const Key('prev'),
                        onPressed: s.isFirst ? null : () => controller.goTo(s.index - 1),
                        icon: const Icon(Icons.chevron_left),
                        label: const Text('Previous'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: s.isLast
                          ? FilledButton.icon(
                              key: const Key('submit'),
                              onPressed: s.allAnswered || !s.isLearning ? () => _submit(context, ref) : null,
                              icon: const Icon(Icons.check),
                              label: const Text('Submit'),
                            )
                          : FilledButton.icon(
                              key: const Key('next'),
                              onPressed: () => controller.goTo(s.index + 1),
                              icon: const Icon(Icons.chevron_right),
                              label: const Text('Next'),
                            ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    try {
      final r = await ref.read(sessionControllerProvider.notifier).submit();
      if (context.mounted) context.pushReplacement('/round/${r.roundId}/result${r.newlyMastered ? '?mastered=1' : ''}');
    } on AppFailure catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

/// Score, PASS / NOT PASSED, weak concepts and next actions.
class RoundResultScreen extends ConsumerWidget {
  const RoundResultScreen({super.key, required this.roundId, this.newlyMastered = false});
  final int roundId;
  final bool newlyMastered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewAsync = ref.watch(roundReviewProvider(roundId));
    return Scaffold(
      appBar: AppBar(title: const Text('Round Result'), automaticallyImplyLeading: false),
      body: AsyncValueView(
        value: reviewAsync,
        builder: (r) {
          final learning = r.round.isLearning;
          final passed = r.passed;
          final color = passed ? AppColors.correct : AppColors.incorrect;
          final headline = learning
              ? (passed ? 'EXCELLENT! 5/5 – MASTERED' : 'NOT PASSED – RETRY REQUIRED')
              : 'Practice complete';
          return ResponsiveBody(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Card(
                color: color.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Icon(passed ? Icons.emoji_events : Icons.refresh, size: 56, color: color),
                    const SizedBox(height: 8),
                    Text('${r.score}/${r.results.length}',
                        key: const Key('round-score'),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, color: color)),
                    const SizedBox(height: 4),
                    Text(headline,
                        key: const Key('round-verdict'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: color)),
                    const SizedBox(height: 8),
                    Text(
                      learning
                          ? passed
                              ? 'You completed this learning round. Your next five questions are ready.'
                              : 'You scored ${r.score}/5. Read the explanations below, then retry with a new set of '
                                  'questions. You must achieve 5/5 to pass the round.'
                          : 'Practice results are recorded in your history and weak-area tracker.',
                      textAlign: TextAlign.center,
                    ),
                    if (r.mastery != null) ...[
                      const SizedBox(height: 12),
                      LabeledProgress(
                        value: r.mastery!.completion,
                        label: '${categoryById(r.mastery!.categoryId).shortName}: '
                            '${r.mastery!.covered}/${r.mastery!.totalQuestions} covered',
                        color: color,
                      ),
                    ],
                  ]),
                ),
              ),
              if (r.weakConcepts.isNotEmpty) ...[
                const SectionTitle('Your weak areas from this round'),
                for (var i = 0; i < r.weakConcepts.length; i++)
                  ListTile(
                    dense: true,
                    leading: CircleAvatar(radius: 12, child: Text('${i + 1}', style: const TextStyle(fontSize: 12))),
                    title: Text(r.weakConcepts[i]),
                  ),
              ],
              const SizedBox(height: 12),
              FilledButton.icon(
                key: const Key('review-explanations'),
                onPressed: () => context.push('/round/$roundId/review'),
                icon: const Icon(Icons.menu_book),
                label: const Text('Review explanations'),
              ),
              const SizedBox(height: 10),
              if (learning && newlyMastered)
                FilledButton.tonalIcon(
                  onPressed: () => context.pushReplacement('/mastery/${r.round.categoryId}'),
                  icon: const Icon(Icons.workspace_premium),
                  label: const Text('Category mastered: see summary'),
                )
              else if (learning && !passed)
                FilledButton.tonalIcon(
                  key: const Key('retry'),
                  onPressed: () => context.pushReplacement('/retry/${r.round.categoryId}?roundId=$roundId'),
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry'),
                )
              else if (learning)
                FilledButton.tonalIcon(
                  key: const Key('next-round'),
                  onPressed: () => startLearningRound(context, ref, r.round.categoryId!, replace: true),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Next five questions'),
                ),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () => context.go(learning ? '/learn' : '/practice'), child: const Text('Done')),
            ]),
          );
        },
      ),
    );
  }
}

/// Explanations for all questions of a round (pager on phones, list on wide screens).
class RoundReviewScreen extends ConsumerWidget {
  const RoundReviewScreen({super.key, required this.roundId});
  final int roundId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewAsync = ref.watch(roundReviewProvider(roundId));
    return Scaffold(
      appBar: AppBar(title: const Text('Detailed Explanations')),
      body: AsyncValueView(
        value: reviewAsync,
        builder: (r) => ResponsiveBody(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: r.results.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => ExplanationCard(
              result: r.results[i],
              number: i + 1,
              order: r.round.optionOrder[r.results[i].question.id],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shown after a failed learning round: what went wrong and a new set of questions.
class RetryScreen extends ConsumerWidget {
  const RetryScreen({super.key, required this.categoryId, this.roundId});
  final String categoryId;
  final int? roundId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = roundId == null ? null : ref.watch(roundReviewProvider(roundId!)).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Retry Required')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const Icon(Icons.replay_circle_filled, size: 64, color: AppColors.warning),
          const SizedBox(height: 8),
          Text('NOT PASSED – RETRY REQUIRED',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(
            review == null
                ? 'You must achieve 5/5 to pass this learning round.'
                : 'You scored ${review.score}/5. The next round is a NEW set of five questions that prioritizes '
                    'the questions and concepts you missed.',
            textAlign: TextAlign.center,
          ),
          if (review != null && review.weakConcepts.isNotEmpty) ...[
            const SectionTitle('Focus on these concepts'),
            for (final c in review.weakConcepts)
              ListTile(dense: true, leading: const Icon(Icons.track_changes, color: AppColors.warning), title: Text(c)),
          ],
          const SizedBox(height: 16),
          if (roundId != null)
            OutlinedButton.icon(
              onPressed: () => context.push('/round/$roundId/review'),
              icon: const Icon(Icons.menu_book),
              label: const Text('Study the explanations first'),
            ),
          const SizedBox(height: 10),
          FilledButton.icon(
            key: const Key('start-retry'),
            onPressed: () => startLearningRound(context, ref, categoryId, replace: true),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start new round'),
          ),
        ]),
      ),
    );
  }
}

/// Celebrates completing a category and points to the next one.
class CategoryMasteryScreen extends ConsumerWidget {
  const CategoryMasteryScreen({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = categoryById(categoryId);
    final mastery = ref.watch(masteryMapProvider).value;
    final m = mastery?[categoryId];
    final nextIdx = kCategories.indexWhere((c) => c.id == categoryId) + 1;
    final next = nextIdx < kCategories.length ? kCategories[nextIdx] : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Category Mastered')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(24), children: [
          const Icon(Icons.workspace_premium, size: 80, color: AppColors.correct),
          const SizedBox(height: 12),
          Text(info.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('MASTERED', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.correct)),
          if (m != null) ...[
            const SizedBox(height: 16),
            StatGrid(children: [
              StatTile(label: 'Questions covered', value: '${m.covered}/${m.totalQuestions}', icon: Icons.task_alt),
              StatTile(label: 'Perfect rounds', value: '${m.roundsPassed}', icon: Icons.emoji_events_outlined),
              StatTile(label: 'Retries', value: '${m.roundsFailed}', icon: Icons.replay),
            ]),
          ],
          const SizedBox(height: 24),
          if (next != null)
            FilledButton.icon(
              onPressed: () => context.go('/learn/${next.id}'),
              icon: const Icon(Icons.lock_open),
              label: Text('Unlocked: ${next.shortName}'),
            )
          else
            FilledButton.icon(
              onPressed: () => context.go('/exam'),
              icon: const Icon(Icons.timer),
              label: const Text('All domains mastered: take a mock exam'),
            ),
          const SizedBox(height: 10),
          OutlinedButton(onPressed: () => context.go('/learn'), child: const Text('Back to Learning Journey')),
        ]),
      ),
    );
  }
}
