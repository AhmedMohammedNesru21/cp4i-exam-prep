import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/presentation/learn_screens.dart';
import '../../learning/presentation/progress_providers.dart';
import '../../profile/presentation/settings_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dashboardProvider);
    final name = ref.watch(settingsProvider).displayName;
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: AsyncValueView(
        value: dataAsync,
        builder: (d) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(dashboardProvider),
          child: ResponsiveBody(
            maxWidth: 1000,
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Text(name.isEmpty ? 'Welcome back' : 'Welcome back, $name',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${AppConstants.certificationTitle} (${AppConstants.examCode})'),
              const SizedBox(height: 16),
              Card(
                color: AppColors.navySurface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Overall progress: ${d.overallProgress.toStringAsFixed(0)}%',
                        key: const Key('overall-progress'),
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: d.overallProgress / 100, minHeight: 10, color: AppColors.blueLight),
                    const SizedBox(height: 8),
                    Text('Categories mastered: ${d.categoriesMastered}/${kCategories.length} · '
                        '${d.questionsCovered}/${d.totalQuestions} questions covered',
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      key: const Key('continue-learning'),
                      style: FilledButton.styleFrom(backgroundColor: AppColors.blue),
                      onPressed: () {
                        if (d.activeRound != null) {
                          context.push('/session');
                        } else if (d.nextCategoryId != null) {
                          context.push('/learn/${d.nextCategoryId}');
                        } else {
                          context.go('/exam');
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: Text(d.activeRound != null
                          ? 'Resume round in progress'
                          : d.nextCategoryId != null
                              ? 'Continue Learning: ${categoryById(d.nextCategoryId!).shortName}'
                              : 'Take a mock exam'),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              StatGrid(children: [
                StatTile(label: 'Total questions', value: '${d.totalQuestions}', icon: Icons.library_books_outlined),
                StatTile(label: 'Questions attempted', value: '${d.totals.distinctQuestions}', icon: Icons.edit_note),
                StatTile(label: 'Questions remaining', value: '${d.questionsRemaining}', icon: Icons.pending_outlined),
                StatTile(label: 'Correct answers', value: '${d.totals.correct}', icon: Icons.check_circle_outline, color: AppColors.correct),
                StatTile(label: 'Accuracy', value: formatPercent(d.totals.accuracy), icon: Icons.percent),
                StatTile(label: 'Study streak', value: '${d.studyStreak} days', icon: Icons.local_fire_department_outlined, color: Colors.deepOrange),
                StatTile(label: 'Mastery streak', value: '${d.masteryStreak} rounds', icon: Icons.bolt, color: AppColors.warning),
                StatTile(label: 'Mock exams', value: '${d.examAttempts}', icon: Icons.timer_outlined),
                StatTile(
                  label: 'Last exam score',
                  value: d.lastExam == null ? '–' : '${d.lastExam!.correct}/${d.lastExam!.questionIds.length}',
                  icon: Icons.score,
                  color: d.lastExam == null ? null : (d.lastExam!.passed ? AppColors.correct : AppColors.incorrect),
                ),
              ]),
              if (d.weakestCategories.isNotEmpty) ...[
                const SectionTitle('Weakest categories'),
                for (final w in d.weakestCategories)
                  ListTile(
                    leading: Icon(categoryIcon(w.categoryId), color: AppColors.warning),
                    title: Text(categoryById(w.categoryId).name),
                    trailing: Text(formatPercent(w.accuracy, decimals: 0)),
                    onTap: () => context.push('/learn/${w.categoryId}'),
                  ),
              ],
              SectionTitle('Category progress',
                  trailing: TextButton(onPressed: () => context.push('/overview'), child: const Text('Exam blueprint'))),
              for (final c in kCategories)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CategoryCard(
                    info: c,
                    mastery: d.mastery[c.id],
                    unlocked: c.sortOrder == 1 || (d.mastery[kCategories[c.sortOrder - 2].id]?.isMastered ?? false),
                  ),
                ),
              const SizedBox(height: 8),
              Text(AppConstants.disclaimer, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Certification overview: exam format, blueprint and the learning method.
class CertificationOverviewScreen extends StatelessWidget {
  const CertificationOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Certification Overview')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text(AppConstants.certificationTitle, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Exam ${AppConstants.examCode}'),
          const SizedBox(height: 12),
          const StatGrid(children: [
            StatTile(label: 'Questions', value: '64', icon: Icons.quiz_outlined),
            StatTile(label: 'Duration', value: '90 min', icon: Icons.timer_outlined),
            StatTile(label: 'Passing score', value: '43/64', icon: Icons.verified_outlined),
            StatTile(label: 'Domains', value: '7', icon: Icons.category_outlined),
          ]),
          const SizedBox(height: 6),
          Text('Exam format per IBM\'s published information; always verify the current details on the IBM certification site.',
              style: theme.textTheme.bodySmall),
          const SectionTitle('Exam blueprint'),
          Card(
            child: Column(children: [
              for (final c in kCategories)
                ListTile(
                  leading: Icon(categoryIcon(c.id)),
                  title: Text(c.name),
                  subtitle: Text(c.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('${c.weight}%', style: const TextStyle(fontWeight: FontWeight.w700)),
                    Text('${c.examQuestions} in mock', style: theme.textTheme.bodySmall),
                  ]),
                ),
            ]),
          ),
          const SectionTitle('How this app works'),
          const _Step(1, 'Choose the next domain', 'Domains unlock in order. Revisit mastered domains anytime.'),
          const _Step(2, 'Answer five questions', 'One at a time, with Previous/Next navigation and bookmarks.'),
          const _Step(3, 'Only 5/5 passes', '4/5 or below means retry. Multiple-select questions need every correct option.'),
          const _Step(4, 'Study the explanations', 'Every option is explained, with scenarios, architecture implications and exam tips.'),
          const _Step(5, 'Retry until mastery', 'New sets prioritize missed questions and weak concepts. A domain is mastered once every question is covered.'),
          const _Step(6, 'Prove readiness', 'Pass timed 64-question mock exams (43/64) repeatedly. Readiness needs three consecutive passes.'),
          const SizedBox(height: 12),
          Text(AppConstants.disclaimer, style: theme.textTheme.bodySmall),
        ]),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.n, this.title, this.body);
  final int n;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => ListTile(
        leading: CircleAvatar(child: Text('$n')),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(body),
      );
}
