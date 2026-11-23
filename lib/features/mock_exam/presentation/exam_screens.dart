import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/domain/learning_models.dart';
import '../../learning/presentation/progress_providers.dart';
import '../../questions/presentation/question_widgets.dart';
import 'exam_controller.dart';

/// Mock exam landing page: rules, start/resume, history, readiness.
class ExamHomeScreen extends ConsumerWidget {
  const ExamHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(examControllerProvider).value;
    final exams = ref.watch(completedExamsProvider).value ?? const [];
    final mastery = ref.watch(masteryMapProvider).value ?? const {};
    final allMastered = mastery.length == kCategories.length && mastery.values.every((m) => m.isMastered);
    final last3 = exams.take(3).toList();
    final ready = allMastered && last3.length == 3 && last3.every((e) => e.passed);
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Exam')),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Full certification simulation', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const _Rule(Icons.quiz_outlined, '${AppConstants.examQuestionCount} questions weighted by the official blueprint'),
                const _Rule(Icons.timer_outlined, '90-minute countdown; submits automatically when time expires'),
                const _Rule(Icons.flag_outlined, 'Navigate freely and mark questions for review'),
                const _Rule(Icons.visibility_off_outlined, 'No feedback or explanations until you submit'),
                const _Rule(Icons.verified_outlined, 'Pass benchmark: ${AppConstants.examPassMark}/${AppConstants.examQuestionCount} (about 67%); verify against current IBM information'),
                const SizedBox(height: 6),
                Text(
                  'This benchmark is separate from the 5/5 learning mastery rule.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          if (!allMastered)
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline, color: AppColors.warning),
                title: Text('Recommended: master all seven domains first'),
                subtitle: Text('You can take mock exams anytime, but readiness requires mastery plus three consecutive passes.'),
              ),
            ),
          const SizedBox(height: 12),
          FilledButton.icon(
            key: const Key('start-exam'),
            onPressed: () async {
              await ref.read(examControllerProvider.notifier).start();
              if (context.mounted) context.push('/exam/session');
            },
            icon: Icon(active != null ? Icons.play_arrow : Icons.timer),
            label: Text(active != null ? 'Resume exam in progress' : 'Start 64-question exam'),
          ),
          const SectionTitle('Certification readiness'),
          Card(
            child: ListTile(
              leading: Icon(ready ? Icons.verified : Icons.hourglass_bottom, color: ready ? AppColors.correct : AppColors.warning),
              title: Text(ready ? 'READY for C1000-204' : 'Not yet ready'),
              subtitle: Text(
                'Domains mastered: ${mastery.values.where((m) => m.isMastered).length}/7 · '
                'Passed mocks: ${exams.where((e) => e.passed).length}/${exams.length} · '
                'Last 3 all passed: ${last3.length == 3 && last3.every((e) => e.passed) ? 'yes' : 'no'}',
              ),
            ),
          ),
          if (exams.isNotEmpty) ...[
            const SectionTitle('Exam history'),
            for (final e in exams)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(e.passed ? Icons.check_circle : Icons.cancel, color: e.passed ? AppColors.correct : AppColors.incorrect),
                  title: Text('${e.correct}/${e.questionIds.length} · ${formatPercent(e.percentage ?? 0)}'),
                  subtitle: Text(formatDate(e.startedAt)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/exam/result/${e.id}'),
                ),
              ),
          ],
        ]),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule(this.icon, this.text);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ]),
      );
}

/// The timed exam: countdown, navigation grid, flags, submit.
class ExamScreen extends ConsumerStatefulWidget {
  const ExamScreen({super.key});
  @override
  ConsumerState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends ConsumerState<ExamScreen> {
  Timer? _ticker;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    WidgetsBinding.instance.addPostFrameCallback((_) => _tick());
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _tick() {
    if (!mounted) return;
    final controller = ref.read(examControllerProvider.notifier);
    if (ref.read(examControllerProvider).value != null && controller.isExpired) {
      _submit(auto: true);
    } else {
      setState(() {});
    }
  }

  Future<void> _submit({bool auto = false}) async {
    if (_submitting) return;
    final s = ref.read(examControllerProvider).value;
    if (s == null) return;
    if (!auto) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Submit exam?'),
          content: Text('Answered: ${s.answeredCount}/${s.questions.length}\n'
              'Unanswered: ${s.unansweredCount}\nMarked for review: ${s.flags.length}'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep working')),
            FilledButton(key: const Key('confirm-submit'), onPressed: () => Navigator.pop(ctx, true), child: const Text('Submit')),
          ],
        ),
      );
      if (ok != true) return;
    }
    _submitting = true;
    _ticker?.cancel();
    final id = await ref.read(examControllerProvider.notifier).submit();
    if (!mounted) return;
    if (auto) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Time expired. Your exam was submitted automatically.')));
    }
    context.pushReplacement('/exam/result/$id');
  }

  void _openNavigator(ExamSession s) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Answered ${s.answeredCount} · Unanswered ${s.unansweredCount} · Marked ${s.flags.length}'),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (var i = 0; i < s.questions.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    ref.read(examControllerProvider.notifier).goTo(i);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: s.isAnswered(s.questions[i]) ? AppColors.blue.withValues(alpha: 0.85) : null,
                      border: Border.all(
                        color: s.flags.contains(s.questions[i].id) ? AppColors.warning : Theme.of(ctx).colorScheme.outline,
                        width: s.flags.contains(s.questions[i].id) ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('${i + 1}', style: TextStyle(color: s.isAnswered(s.questions[i]) ? Colors.white : null)),
                  ),
                ),
            ]),
            const SizedBox(height: 12),
            const Text('Blue = answered · Amber border = marked for review'),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(examControllerProvider);
    final controller = ref.read(examControllerProvider.notifier);
    return AsyncValueView(
      value: sessionAsync,
      builder: (s) {
        if (s == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Mock Exam')),
            body: EmptyState(
              icon: Icons.timer_off_outlined,
              title: 'No exam in progress',
              action: FilledButton(onPressed: () => context.go('/exam'), child: const Text('Back')),
            ),
          );
        }
        final q = s.current;
        final remaining = controller.remaining;
        final low = remaining < const Duration(minutes: 10);
        final flagged = s.flags.contains(q.id);
        return Scaffold(
          appBar: AppBar(
            title: Text('Question ${s.index + 1}/${s.questions.length}', key: const Key('exam-progress')),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    formatDuration(remaining),
                    key: const Key('exam-timer'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: low ? AppColors.warning : Colors.white,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
              IconButton(tooltip: 'Question navigator', icon: const Icon(Icons.grid_view), onPressed: () => _openNavigator(s)),
            ],
          ),
          body: SafeArea(
            child: ResponsiveBody(
              child: Column(children: [
                LinearProgressIndicator(value: s.answeredCount / s.questions.length),
                Expanded(
                  child: ListView(padding: const EdgeInsets.all(16), children: [
                    Row(children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InfoChip(categoryById(q.categoryId).shortName, icon: Icons.folder_outlined),
                        ),
                      ),
                      TextButton.icon(
                        key: const Key('flag'),
                        onPressed: () => controller.toggleFlag(q.id),
                        icon: Icon(flagged ? Icons.flag : Icons.outlined_flag, color: flagged ? AppColors.warning : null),
                        label: Text(flagged ? 'Marked' : 'Mark for review'),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Text(q.text, style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.4)),
                    if (q.isMultiple)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Select ${q.requiredSelections}.', style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.warning)),
                      ),
                    const SizedBox(height: 16),
                    AnswerOptions(
                      question: q,
                      order: s.orderFor(q),
                      selected: s.selectionFor(q.id),
                      onToggle: (o) => controller.toggleOption(q.id, o).catchError((Object e) {
                        if (e is AppFailure) _submit(auto: true);
                      }),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: s.index == 0 ? null : () => controller.goTo(s.index - 1),
                        child: const Text('Previous'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: s.index == s.questions.length - 1
                          ? FilledButton(key: const Key('exam-submit'), onPressed: _submit, child: const Text('Submit'))
                          : FilledButton(
                              key: const Key('exam-next'),
                              onPressed: () => controller.goTo(s.index + 1),
                              child: const Text('Next'),
                            ),
                    ),
                  ]),
                ),
                TextButton(onPressed: _submit, child: const Text('Submit exam now')),
              ]),
            ),
          ),
        );
      },
    );
  }
}

/// PASS/FAIL, score, time, per-domain breakdown, weakest areas, recommendations.
class ExamResultScreen extends ConsumerWidget {
  const ExamResultScreen({super.key, required this.examId});
  final int examId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examAsync = ref.watch(examByIdProvider(examId));
    final bank = ref.watch(questionBankProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Result')),
      body: AsyncValueView(
        value: examAsync,
        builder: (e) {
          final color = e.passed ? AppColors.correct : AppColors.incorrect;
          final total = e.questionIds.length;
          final correct = e.correct ?? 0;
          final weakConcepts = <String, int>{};
          if (bank != null) {
            for (final id in e.questionIds) {
              final q = bank[id];
              if (!q.isAnsweredCorrectly(e.answers[id] ?? const [])) {
                weakConcepts.update(q.technicalConcept, (v) => v + 1, ifAbsent: () => 1);
              }
            }
          }
          final weakest = weakConcepts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
          final revision = e.byCategory.entries.where((c) => c.value.total > 0 && c.value.percentage < 70).toList()
            ..sort((a, b) => a.value.percentage.compareTo(b.value.percentage));
          return ResponsiveBody(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Card(
                color: color.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Text(e.passed ? 'PASS' : 'FAIL',
                        key: const Key('exam-verdict'),
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: color)),
                    Text('$correct/$total · ${formatPercent(e.percentage ?? 0)}',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text('Benchmark ${AppConstants.examPassMark}/${AppConstants.examQuestionCount}'),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              StatGrid(children: [
                StatTile(label: 'Correct', value: '$correct', icon: Icons.check_circle_outline, color: AppColors.correct),
                StatTile(label: 'Incorrect', value: '${total - correct}', icon: Icons.cancel_outlined, color: AppColors.incorrect),
                StatTile(
                  label: 'Unanswered',
                  value: '${e.questionIds.where((id) => (e.answers[id] ?? const []).isEmpty).length}',
                  icon: Icons.help_outline,
                ),
                StatTile(label: 'Time used', value: formatDuration(Duration(seconds: e.durationSeconds ?? 0)), icon: Icons.timer_outlined),
              ]),
              const SectionTitle('Category breakdown'),
              for (final c in kCategories)
                if (e.byCategory[c.id] != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LabeledProgress(
                      value: e.byCategory[c.id]!.percentage / 100,
                      label: '${c.shortName}: ${e.byCategory[c.id]!.correct}/${e.byCategory[c.id]!.total} '
                          '(${formatPercent(e.byCategory[c.id]!.percentage, decimals: 0)})',
                      color: e.byCategory[c.id]!.percentage >= 70 ? AppColors.correct : AppColors.warning,
                    ),
                  ),
              if (weakest.isNotEmpty) ...[
                const SectionTitle('Weakest areas'),
                for (final w in weakest.take(6))
                  ListTile(dense: true, leading: const Icon(Icons.track_changes, color: AppColors.warning), title: Text(w.key), trailing: Text('${w.value} missed')),
              ],
              const SectionTitle('Recommended revision'),
              if (revision.isEmpty)
                const Text('All domains are at or above 70%. Keep the streak going with another timed mock exam.')
              else
                for (final r in revision)
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: Text(categoryById(r.key).name),
                    subtitle: Text('Scored ${formatPercent(r.value.percentage, decimals: 0)}. Practise this domain and review weak concepts.'),
                    onTap: () => context.go('/learn/${r.key}'),
                  ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.push('/exam/review/$examId'),
                icon: const Icon(Icons.menu_book),
                label: const Text('Review all answers and explanations'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: () => context.go('/exam'), child: const Text('Done')),
            ]),
          );
        },
      ),
    );
  }
}

class ExamReviewScreen extends ConsumerStatefulWidget {
  const ExamReviewScreen({super.key, required this.examId});
  final int examId;
  @override
  ConsumerState<ExamReviewScreen> createState() => _ExamReviewScreenState();
}

class _ExamReviewScreenState extends ConsumerState<ExamReviewScreen> {
  bool _incorrectOnly = true;

  @override
  Widget build(BuildContext context) {
    final examAsync = ref.watch(examByIdProvider(widget.examId));
    final bankAsync = ref.watch(questionBankProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Review')),
      body: AsyncValueView(
        value: examAsync,
        builder: (e) => AsyncValueView(
          value: bankAsync,
          builder: (bank) {
            final results = [
              for (final id in e.questionIds)
                QuestionResult(question: bank[id], selected: e.answers[id] ?? const [], correct: bank[id].isAnsweredCorrectly(e.answers[id] ?? const [])),
            ];
            final shown = _incorrectOnly ? results.where((r) => !r.correct).toList() : results;
            return ResponsiveBody(
              child: ListView(padding: const EdgeInsets.all(16), children: [
                SwitchListTile(
                  title: const Text('Show incorrect answers only'),
                  value: _incorrectOnly,
                  onChanged: (v) => setState(() => _incorrectOnly = v),
                ),
                for (final r in shown)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ExplanationCard(
                      result: r,
                      number: e.questionIds.indexOf(r.question.id) + 1,
                      order: e.optionOrder[r.question.id],
                    ),
                  ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
