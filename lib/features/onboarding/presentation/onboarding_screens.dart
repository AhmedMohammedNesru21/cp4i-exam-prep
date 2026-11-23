import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../profile/presentation/settings_controller.dart';

/// Seeds/loads the offline question bank, then routes to onboarding or home.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = ref.watch(questionBankProvider);
    if (bank.hasValue) {
      // Navigate once the bank is ready (also covers an already-loaded bank).
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        context.go(ref.read(settingsProvider).onboardingComplete ? '/home' : '/onboarding');
      });
    }
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.hub, size: 72, color: AppColors.blueLight),
          const SizedBox(height: 16),
          const Text(AppConstants.appName, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('${AppConstants.examCode} · CP4I v16.1.0', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 24),
          if (bank.hasError)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Could not load the question bank: ${bank.error}', style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
            )
          else
            const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(color: AppColors.blueLight)),
        ]),
      ),
    );
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pages = PageController();
  final _name = TextEditingController();
  int _page = 0;

  static const _slides = [
    (Icons.school, 'Structured mastery', 'Seven exam domains, unlocked in order. Each learning round has exactly five questions.'),
    (Icons.verified, 'Only 5/5 passes', 'Score 4/5 or less and you retry with a new set that targets your weak concepts. A domain is mastered when every question has been covered.'),
    (Icons.menu_book, 'Learn from every answer', 'Each question explains every option, plus scenarios, architecture implications and exam tips.'),
    (Icons.timer, 'Realistic mock exams', '64 questions, 90 minutes, weighted like the real blueprint. Pass at 43/64, repeatedly.'),
  ];

  @override
  void dispose() {
    _pages.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(settingsProvider.notifier).completeOnboarding(displayName: _name.text.trim());
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final last = _page == _slides.length;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView(
              controller: _pages,
              onPageChanged: (i) => setState(() => _page = i),
              children: [
                for (final s in _slides)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(s.$1, size: 88, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 24),
                      Text(s.$2, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Text(s.$3, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                  ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('What should we call you?', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    TextField(
                      key: const Key('name-field'),
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Name (optional)', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 24),
                    Text(AppConstants.disclaimer, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              TextButton(onPressed: _finish, child: const Text('Skip')),
              const Spacer(),
              FilledButton(
                key: const Key('onboarding-next'),
                onPressed: last
                    ? _finish
                    : () => _pages.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut),
                child: Text(last ? 'Get started' : 'Next'),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
