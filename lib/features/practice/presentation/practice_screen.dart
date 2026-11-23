import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/presentation/session_controller.dart';
import '../domain/practice_selector.dart';

IconData practiceIcon(PracticeMode m) => switch (m) {
      PracticeMode.category => Icons.folder_open,
      PracticeMode.random => Icons.shuffle,
      PracticeMode.advanced => Icons.trending_up,
      PracticeMode.scenario => Icons.account_tree_outlined,
      PracticeMode.troubleshooting => Icons.build_circle_outlined,
      PracticeMode.weakAreas => Icons.track_changes,
      PracticeMode.bookmarked => Icons.bookmarks_outlined,
      PracticeMode.incorrect => Icons.error_outline,
      PracticeMode.advancedRevision => Icons.school,
    };

class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  Future<void> _start(BuildContext context, WidgetRef ref, PracticeMode mode, {String? categoryId}) async {
    final count = await ref.read(sessionControllerProvider.notifier).startPractice(mode, categoryId: categoryId);
    if (!context.mounted) return;
    if (count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(switch (mode) {
          PracticeMode.bookmarked => 'No bookmarked questions yet. Tap the bookmark icon on any question.',
          PracticeMode.incorrect => 'No incorrect answers to retry. Great work!',
          PracticeMode.weakAreas => 'No weak concepts recorded yet. Answer some questions first.',
          _ => 'No questions available for this mode.',
        }),
      ));
      return;
    }
    context.push('/session');
  }

  Future<void> _pickCategory(BuildContext context, WidgetRef ref) async {
    final id = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          for (final c in kCategories)
            ListTile(title: Text(c.name), subtitle: Text('${c.weight}% of exam'), onTap: () => Navigator.pop(ctx, c.id)),
        ]),
      ),
    );
    if (id != null && context.mounted) await _start(context, ref, PracticeMode.category, categoryId: id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(sessionControllerProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Practice')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const Text('Unlimited five-question practice rounds with full explanations. Practice does not change '
              'learning mastery, but every answer updates your weak-area tracker.'),
          if (active != null) ...[
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.play_circle),
                title: const Text('Resume your round in progress'),
                subtitle: Text('${active.answeredCount}/${active.questions.length} answered'),
                onTap: () => context.push('/session'),
              ),
            ),
          ],
          const SizedBox(height: 8),
          for (final mode in PracticeMode.values)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Card(
                child: ListTile(
                  key: Key(mode.code),
                  minVerticalPadding: 14,
                  leading: Icon(practiceIcon(mode), color: Theme.of(context).colorScheme.primary),
                  title: Text(mode.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(mode.description),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => mode == PracticeMode.category ? _pickCategory(context, ref) : _start(context, ref, mode),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.track_changes),
              title: const Text('Review weak concepts'),
              subtitle: const Text('See which concepts need work and how you are improving.'),
              onTap: () => context.push('/weak-areas'),
            ),
          ),
        ]),
      ),
    );
  }
}
