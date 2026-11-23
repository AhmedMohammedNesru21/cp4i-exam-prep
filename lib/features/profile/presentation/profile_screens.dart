import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/presentation/progress_providers.dart';
import 'settings_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final d = ref.watch(dashboardProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Row(children: [
            const CircleAvatar(radius: 28, child: Icon(Icons.person, size: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(settings.displayName.isEmpty ? 'Candidate' : settings.displayName,
                    style: Theme.of(context).textTheme.titleLarge),
                const Text('Target: ${AppConstants.examCode}'),
              ]),
            ),
          ]),
          if (d != null) ...[
            const SizedBox(height: 16),
            StatGrid(children: [
              StatTile(label: 'Progress', value: formatPercent(d.overallProgress, decimals: 0), icon: Icons.donut_large),
              StatTile(label: 'Domains mastered', value: '${d.categoriesMastered}/7', icon: Icons.workspace_premium_outlined),
              StatTile(label: 'Accuracy', value: formatPercent(d.totals.accuracy, decimals: 0), icon: Icons.percent),
              StatTile(label: 'Mock exams', value: '${d.examAttempts}', icon: Icons.timer_outlined),
            ]),
          ],
          const SizedBox(height: 16),
          Card(
            child: Column(children: [
              _Nav(Icons.insights, 'Performance analytics', '/analytics'),
              _Nav(Icons.history, 'Study history', '/history'),
              _Nav(Icons.track_changes, 'Weak areas', '/weak-areas'),
              _Nav(Icons.bookmarks_outlined, 'Bookmarks', '/bookmarks'),
              _Nav(Icons.info_outline, 'Certification overview', '/overview'),
              _Nav(Icons.settings_outlined, 'Settings', '/settings'),
            ]),
          ),
          const SizedBox(height: 16),
          Text(AppConstants.disclaimer, style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  const _Nav(this.icon, this.title, this.path);
  final IconData icon;
  final String title;
  final String path;
  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(path),
      );
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final bank = ref.watch(questionBankProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          const SectionTitle('Appearance'),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.brightness_auto)),
              ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode)),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode)),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => controller.setThemeMode(s.first),
          ),
          const SectionTitle('Profile'),
          TextFormField(
            initialValue: settings.displayName,
            decoration: const InputDecoration(labelText: 'Display name', border: OutlineInputBorder()),
            onFieldSubmitted: controller.setDisplayName,
          ),
          const SectionTitle('About'),
          ListTile(
            title: const Text('Question bank'),
            subtitle: Text('${bank?.length ?? '…'} original practice questions, stored offline on this device'),
          ),
          const ListTile(
            title: Text('Learning rule'),
            subtitle: Text('Rounds of exactly 5 questions; only 5/5 passes. Domains unlock in order.'),
          ),
          const ListTile(
            title: Text('Mock exam'),
            subtitle: Text('64 questions, 90 minutes, pass at 43/64.'),
          ),
          const ListTile(title: Text('Offline'), subtitle: Text('All features work without an internet connection.')),
          const SizedBox(height: 8),
          Text(AppConstants.disclaimer, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              ref.invalidate(dashboardProvider);
              ref.read(dataVersionProvider.notifier).bump();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Statistics refreshed')));
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh statistics'),
          ),
        ]),
      ),
    );
  }
}
