import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/analytics/presentation/analytics_screens.dart';
import '../../features/bookmarks/presentation/bookmarks_screen.dart';
import '../../features/dashboard/presentation/dashboard_screens.dart';
import '../../features/learning/presentation/learn_screens.dart';
import '../../features/learning/presentation/round_screens.dart';
import '../../features/mock_exam/presentation/exam_screens.dart';
import '../../features/onboarding/presentation/onboarding_screens.dart';
import '../../features/practice/presentation/practice_screen.dart';
import '../../features/profile/presentation/profile_screens.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootKey = GlobalKey<NavigatorState>();
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _MainShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (_, _) => const HomeScreen())]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/learn',
              builder: (_, _) => const LearnScreen(),
              routes: [
                GoRoute(
                  path: ':categoryId',
                  parentNavigatorKey: rootKey,
                  builder: (_, s) => CategoryDetailsScreen(categoryId: s.pathParameters['categoryId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [GoRoute(path: '/practice', builder: (_, _) => const PracticeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/exam', builder: (_, _) => const ExamHomeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen())]),
        ],
      ),
      GoRoute(path: '/overview', builder: (_, _) => const CertificationOverviewScreen()),
      GoRoute(path: '/session', builder: (_, _) => const RoundScreen()),
      GoRoute(
        path: '/round/:id/result',
        builder: (_, s) => RoundResultScreen(
          roundId: int.parse(s.pathParameters['id']!),
          newlyMastered: s.uri.queryParameters['mastered'] == '1',
        ),
      ),
      GoRoute(path: '/round/:id/review', builder: (_, s) => RoundReviewScreen(roundId: int.parse(s.pathParameters['id']!))),
      GoRoute(
        path: '/retry/:categoryId',
        builder: (_, s) => RetryScreen(
          categoryId: s.pathParameters['categoryId']!,
          roundId: int.tryParse(s.uri.queryParameters['roundId'] ?? ''),
        ),
      ),
      GoRoute(path: '/mastery/:categoryId', builder: (_, s) => CategoryMasteryScreen(categoryId: s.pathParameters['categoryId']!)),
      GoRoute(path: '/exam/session', builder: (_, _) => const ExamScreen()),
      GoRoute(path: '/exam/result/:id', builder: (_, s) => ExamResultScreen(examId: int.parse(s.pathParameters['id']!))),
      GoRoute(path: '/exam/review/:id', builder: (_, s) => ExamReviewScreen(examId: int.parse(s.pathParameters['id']!))),
      GoRoute(path: '/analytics', builder: (_, _) => const AnalyticsScreen()),
      GoRoute(path: '/history', builder: (_, _) => const StudyHistoryScreen()),
      GoRoute(path: '/weak-areas', builder: (_, _) => const WeakAreasScreen()),
      GoRoute(path: '/bookmarks', builder: (_, _) => const BookmarksScreen()),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Bottom navigation on phones, navigation rail on tablets.
class _MainShell extends StatelessWidget {
  const _MainShell({required this.shell});
  final StatefulNavigationShell shell;

  static const _destinations = [
    (Icons.dashboard_outlined, Icons.dashboard, 'Home'),
    (Icons.school_outlined, Icons.school, 'Learn'),
    (Icons.fitness_center_outlined, Icons.fitness_center, 'Practice'),
    (Icons.timer_outlined, Icons.timer, 'Mock Exam'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  void _go(int i) => shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 840;
    if (wide) {
      return Scaffold(
        body: Row(children: [
          NavigationRail(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: _go,
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final d in _destinations)
                NavigationRailDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: Text(d.$3)),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: shell),
        ]),
      );
    }
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _go,
        destinations: [
          for (final d in _destinations) NavigationDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: d.$3),
        ],
      ),
    );
  }
}
