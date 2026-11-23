import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../core/providers.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../learning/domain/learning_models.dart';
import '../../learning/presentation/progress_providers.dart';
import '../../learning/presentation/session_controller.dart';
import '../../practice/domain/practice_selector.dart';
import '../../questions/presentation/question_widgets.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idsAsync = ref.watch(bookmarkIdsProvider);
    final bank = ref.watch(questionBankProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: AsyncValueView(
        value: idsAsync,
        builder: (ids) {
          if (ids.isEmpty || bank == null) {
            return const EmptyState(
              icon: Icons.bookmark_border,
              title: 'No bookmarks yet',
              message: 'Tap the bookmark icon on any question to save it for revision.',
            );
          }
          return ResponsiveBody(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              FilledButton.icon(
                onPressed: () async {
                  final n = await ref.read(sessionControllerProvider.notifier).startPractice(PracticeMode.bookmarked);
                  if (n > 0 && context.mounted) context.push('/session');
                },
                icon: const Icon(Icons.play_arrow),
                label: Text('Practise bookmarked questions (${ids.length})'),
              ),
              const SizedBox(height: 12),
              for (final id in ids)
                if (bank.byId(id) != null)
                  Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [Expanded(child: QuestionMeta(question: bank[id])), BookmarkButton(questionId: id)]),
                        const SizedBox(height: 8),
                        Text(bank[id].text),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.9,
                                builder: (_, c) => SingleChildScrollView(
                                  controller: c,
                                  padding: const EdgeInsets.all(12),
                                  child: ExplanationCard(
                                    result: QuestionResult(question: bank[id], selected: const [], correct: false),
                                    showUserAnswer: false,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text('Show answer and explanation'),
                          ),
                        ),
                      ]),
                    ),
                  ),
            ]),
          );
        },
      ),
    );
  }
}
