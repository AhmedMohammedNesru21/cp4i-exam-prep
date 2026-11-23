import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/presentation/session_controller.dart';
import '../../learning/presentation/progress_providers.dart';
import '../../practice/domain/practice_selector.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);
    final activity = ref.watch(dailyActivityProvider).value ?? const [];
    final exams = ref.watch(completedExamsProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Analytics')),
      body: AsyncValueView(
        value: dashboard,
        builder: (d) => ResponsiveBody(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            StatGrid(children: [
              StatTile(label: 'Answers given', value: '${d.totals.answers}', icon: Icons.edit_note),
              StatTile(label: 'Overall accuracy', value: formatPercent(d.totals.accuracy), icon: Icons.percent),
              StatTile(label: 'Coverage', value: formatPercent(d.overallProgress), icon: Icons.task_alt),
              StatTile(label: 'Mocks passed', value: '${exams.where((e) => e.passed).length}/${exams.length}', icon: Icons.verified_outlined),
            ]),
            const SectionTitle('Accuracy by category'),
            SizedBox(
              height: 220,
              child: BarChart(BarChartData(
                maxY: 100,
                minY: 0,
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32, interval: 25)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) => Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(kCategories[v.toInt()].id.toUpperCase(), style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < kCategories.length; i++)
                    BarChartGroupData(x: i, barRods: [
                      BarChartRodData(
                        toY: d.categoryAccuracy[kCategories[i].id]?.accuracy ?? 0,
                        width: 18,
                        borderRadius: BorderRadius.circular(4),
                        color: (d.categoryAccuracy[kCategories[i].id]?.accuracy ?? 0) >= 70 ? AppColors.correct : AppColors.blue,
                      ),
                    ]),
                ],
              )),
            ),
            const SectionTitle('Daily accuracy (last 30 days)'),
            if (activity.isEmpty)
              const Text('No activity yet.')
            else
              SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: const FlGridData(drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    bottomTitles: AxisTitles(),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32, interval: 25)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      spots: [for (var i = 0; i < activity.length; i++) FlSpot(i.toDouble(), activity[i].accuracy)],
                    ),
                  ],
                )),
              ),
            if (exams.isNotEmpty) ...[
              const SectionTitle('Mock exam scores'),
              SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  minY: 0,
                  maxY: 64,
                  extraLinesData: ExtraLinesData(horizontalLines: [
                    HorizontalLine(y: AppConstants.examPassMark.toDouble(), color: AppColors.correct, dashArray: [6, 4]),
                  ]),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(topTitles: AxisTitles(), rightTitles: AxisTitles(), bottomTitles: AxisTitles()),
                  lineBarsData: [
                    LineChartBarData(
                      color: AppColors.warning,
                      barWidth: 3,
                      spots: [
                        for (var i = 0; i < exams.length; i++)
                          FlSpot(i.toDouble(), (exams.reversed.elementAt(i).correct ?? 0).toDouble()),
                      ],
                    ),
                  ],
                )),
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(onPressed: () => context.push('/history'), icon: const Icon(Icons.history), label: const Text('Study history')),
            const SizedBox(height: 8),
            OutlinedButton.icon(onPressed: () => context.push('/weak-areas'), icon: const Icon(Icons.track_changes), label: const Text('Weak areas')),
          ]),
        ),
      ),
    );
  }
}

class StudyHistoryScreen extends ConsumerWidget {
  const StudyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rounds = ref.watch(roundHistoryProvider);
    final exams = ref.watch(completedExamsProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: const Text('Study History')),
      body: AsyncValueView(
        value: rounds,
        builder: (list) {
          final items = <(DateTime, Widget)>[
            for (final r in list)
              (
                r.completedAt ?? r.startedAt,
                ListTile(
                  leading: Icon(
                    r.status == 'passed' ? Icons.check_circle : r.status == 'failed' ? Icons.replay_circle_filled : Icons.fitness_center,
                    color: r.status == 'passed' ? AppColors.correct : r.status == 'failed' ? AppColors.warning : AppColors.blue,
                  ),
                  title: Text(r.isLearning
                      ? '${categoryById(r.categoryId!).shortName} · Round ${r.roundNumber} · ${r.score}/5 ${r.status == 'passed' ? 'PASS' : 'RETRY'}'
                      : '${PracticeMode.fromCode(r.mode)?.title ?? 'Practice'} · ${r.score}/${r.questionIds.length}'),
                  subtitle: Text(formatDate(r.completedAt ?? r.startedAt)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/round/${r.id}/review'),
                ),
              ),
            for (final e in exams)
              (
                e.completedAt ?? e.startedAt,
                ListTile(
                  leading: Icon(Icons.timer, color: e.passed ? AppColors.correct : AppColors.incorrect),
                  title: Text('Mock exam · ${e.correct}/${e.questionIds.length} ${e.passed ? 'PASS' : 'FAIL'}'),
                  subtitle: Text(formatDate(e.completedAt ?? e.startedAt)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/exam/result/${e.id}'),
                ),
              ),
          ]..sort((a, b) => b.$1.compareTo(a.$1));
          if (items.isEmpty) {
            return const EmptyState(icon: Icons.history, title: 'No study history yet', message: 'Completed rounds and exams appear here.');
          }
          return ResponsiveBody(child: ListView(children: [for (final i in items) i.$2]));
        },
      ),
    );
  }
}

class WeakAreasScreen extends ConsumerWidget {
  const WeakAreasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weak = ref.watch(weakConceptsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Weak Areas')),
      body: AsyncValueView(
        value: weak,
        builder: (list) {
          if (list.isEmpty) {
            return const _NoWeakAreas();
          }
          final active = list.where((w) => w.masteryStatus != 'mastered').toList();
          final recovered = list.where((w) => w.masteryStatus == 'mastered').toList();
          return ResponsiveBody(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              FilledButton.icon(
                onPressed: active.isEmpty
                    ? null
                    : () async {
                        final n = await ref.read(sessionControllerProvider.notifier).startPractice(PracticeMode.weakAreas);
                        if (n > 0 && context.mounted) context.push('/session');
                      },
                icon: const Icon(Icons.fitness_center),
                label: const Text('Practise weak concepts'),
              ),
              const SizedBox(height: 8),
              Text('A concept is recovered after ${AppConstants.conceptRecoveryStreak} consecutive correct answers.',
                  style: Theme.of(context).textTheme.bodySmall),
              SectionTitle('Needs work (${active.length})'),
              for (final w in active)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(w.masteryStatus == 'improving' ? Icons.trending_up : Icons.warning_amber,
                        color: w.masteryStatus == 'improving' ? AppColors.blue : AppColors.warning),
                    title: Text(w.conceptName),
                    subtitle: Text('${categoryById(w.categoryId).shortName} · missed ${w.errorCount}× · '
                        'streak ${w.correctStreak}/${AppConstants.conceptRecoveryStreak}'
                        '${w.lastMissedAt != null ? ' · last missed ${formatDate(w.lastMissedAt!)}' : ''}'),
                    trailing: InfoChip(w.masteryStatus == 'improving' ? 'Improving' : 'Weak',
                        color: w.masteryStatus == 'improving' ? AppColors.blue : AppColors.warning),
                  ),
                ),
              if (recovered.isNotEmpty) ...[
                SectionTitle('Recovered (${recovered.length})'),
                for (final w in recovered)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.check_circle, color: AppColors.correct),
                    title: Text(w.conceptName),
                    subtitle: Text('${categoryById(w.categoryId).shortName} · missed ${w.errorCount}× before'),
                  ),
              ],
            ]),
          );
        },
      ),
    );
  }
}

class _NoWeakAreas extends StatelessWidget {
  const _NoWeakAreas();
  @override
  Widget build(BuildContext context) => const EmptyState(
        icon: Icons.emoji_events_outlined,
        title: 'No weak concepts yet',
        message: 'Concepts you miss are tracked here and prioritized in future rounds.',
      );
}
