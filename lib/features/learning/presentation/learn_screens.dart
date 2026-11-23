import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../domain/learning_models.dart';
import 'progress_providers.dart';
import 'session_controller.dart';

IconData categoryIcon(String id) => switch (id) {
      'ovr' => Icons.hub_outlined,
      'cpa' => Icons.dns_outlined,
      'prd' => Icons.widgets_outlined,
      'sto' => Icons.storage_outlined,
      'scl' => Icons.auto_graph,
      'sec' => Icons.shield_outlined,
      'obs' => Icons.monitor_heart_outlined,
      _ => Icons.school_outlined,
    };

/// Starts the next mastery round and opens the round screen, reporting rule violations.
Future<void> startLearningRound(BuildContext context, WidgetRef ref, String categoryId, {bool replace = false}) async {
  try {
    await ref.read(sessionControllerProvider.notifier).startLearning(categoryId);
    if (!context.mounted) return;
    if (replace) {
      context.pushReplacement('/session');
    } else {
      context.push('/session');
    }
  } on AppFailure catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

/// Category list — the structured learning journey.
class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masteryAsync = ref.watch(masteryMapProvider);
    final engine = ref.watch(masteryEngineProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Journey')),
      body: AsyncValueView(
        value: masteryAsync,
        builder: (mastery) => ResponsiveBody(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text(
              'Master each domain in order. Every round has 5 questions, and only 5/5 passes. '
              'A domain is complete when all of its questions have been covered in passed rounds.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            for (final c in kCategories)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CategoryCard(
                  info: c,
                  mastery: mastery[c.id],
                  unlocked: engine.isUnlocked(c.id, mastery),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.info, required this.mastery, required this.unlocked});
  final CategoryInfo info;
  final CategoryMastery? mastery;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    final m = mastery;
    final status = m?.status ?? MasteryStatus.notStarted;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.push('/learn/${info.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: statusColor(status.label).withValues(alpha: 0.15),
              child: Icon(unlocked ? categoryIcon(info.id) : Icons.lock_outline, color: statusColor(status.label)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${info.sortOrder}. ${info.name}', style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Wrap(spacing: 6, runSpacing: 4, children: [
                  InfoChip(unlocked ? status.label : 'Locked', color: unlocked ? statusColor(status.label) : Colors.grey),
                  InfoChip('${info.weight}% of exam', color: Colors.blueGrey),
                ]),
                const SizedBox(height: 8),
                LabeledProgress(
                  value: m?.completion ?? 0,
                  label: '${m?.covered ?? 0}/${m?.totalQuestions ?? info.targetQuestions} questions covered '
                      '(${((m?.completion ?? 0) * 100).toStringAsFixed(0)}%)',
                  color: statusColor(status.label),
                ),
              ]),
            ),
            const Icon(Icons.chevron_right),
          ]),
        ),
      ),
    );
  }
}

class CategoryDetailsScreen extends ConsumerWidget {
  const CategoryDetailsScreen({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = categoryById(categoryId);
    final masteryAsync = ref.watch(masteryMapProvider);
    final bankAsync = ref.watch(questionBankProvider);
    final weakAsync = ref.watch(weakConceptsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(info.shortName)),
      body: AsyncValueView(
        value: masteryAsync,
        builder: (mastery) {
          final m = mastery[categoryId]!;
          final unlocked = ref.read(masteryEngineProvider).isUnlocked(categoryId, mastery);
          final subs = <String, int>{};
          for (final q in bankAsync.value?.inCategory(categoryId) ?? const []) {
            subs.update(q.subcategory, (v) => v + 1, ifAbsent: () => 1);
          }
          final weak = (weakAsync.value ?? const [])
              .where((w) => w.categoryId == categoryId && w.masteryStatus != 'mastered')
              .toList();
          return ResponsiveBody(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Text(info.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(info.description),
              const SizedBox(height: 12),
              StatGrid(children: [
                StatTile(label: 'Status', value: unlocked ? m.status.label : 'Locked', icon: Icons.flag_outlined),
                StatTile(label: 'Questions covered', value: '${m.covered}/${m.totalQuestions}', icon: Icons.task_alt),
                StatTile(label: 'Rounds passed (5/5)', value: '${m.roundsPassed}', icon: Icons.emoji_events_outlined, color: AppColors.correct),
                StatTile(label: 'Rounds to retry', value: '${m.roundsFailed}', icon: Icons.replay, color: AppColors.warning),
              ]),
              const SizedBox(height: 12),
              LabeledProgress(value: m.completion, label: 'Completion ${(m.completion * 100).toStringAsFixed(1)}%'),
              const SizedBox(height: 16),
              if (!unlocked)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text('Locked'),
                    subtitle: Text('Master the previous category (cover all its questions with 5/5 rounds) to unlock this one.'),
                  ),
                )
              else ...[
                FilledButton.icon(
                  key: const Key('start-round'),
                  onPressed: () => startLearningRound(context, ref, categoryId),
                  icon: Icon(m.status == MasteryStatus.retryRequired ? Icons.replay : Icons.play_arrow),
                  label: Text(switch (m.status) {
                    MasteryStatus.notStarted => 'Start first round',
                    MasteryStatus.retryRequired => 'Retry with new questions',
                    MasteryStatus.mastered => 'Revision round',
                    MasteryStatus.inProgress => 'Next round',
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  m.isMastered
                      ? 'Mastered. Revision rounds focus on previously missed concepts.'
                      : 'About ${m.roundsRemaining} more passed rounds are needed to cover this domain.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (weak.isNotEmpty) ...[
                const SectionTitle('Weak concepts in this domain'),
                for (final w in weak)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.warning_amber, color: AppColors.warning),
                    title: Text(w.conceptName),
                    trailing: Text('${w.errorCount} missed'),
                  ),
              ],
              const SectionTitle('Topics'),
              for (final e in subs.entries)
                ListTile(dense: true, title: Text(e.key), trailing: Text('${e.value} questions')),
            ]),
          );
        },
      ),
    );
  }
}
