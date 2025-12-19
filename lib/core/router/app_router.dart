import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/pomodoro_screen.dart';
import '../../presentation/screens/tasks_screen.dart';
import '../../presentation/screens/gym_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/statistics_screen.dart';
import '../../presentation/screens/settings_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

@singleton
class AppRouter {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/pomodoro',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          // Tab 0: Pomodoro
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pomodoro',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PomodoroScreen(),
                ),
              ),
            ],
          ),
          // Tab 1: Tasks
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tasks',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: TasksScreen(),
                ),
              ),
            ],
          ),
          // Tab 2: Gym
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gym',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: GymScreen(),
                ),
              ),
            ],
          ),
          // Tab 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'statistics',
                    builder: (context, state) => const StatisticsScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
