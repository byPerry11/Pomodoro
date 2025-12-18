import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 64,
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  context,
                  0,
                  Icons.timer_outlined,
                  Icons.timer,
                  AppLocalizations.of(context)!.navPomodoro,
                ),
                _buildNavItem(
                  context,
                  1,
                  Icons.check_circle_outline,
                  Icons.check_circle,
                  AppLocalizations.of(context)!.navGoals,
                ),
                _buildNavItem(
                  context,
                  2,
                  Icons.fitness_center_outlined,
                  Icons.fitness_center,
                  AppLocalizations.of(context)!.navGym,
                ),
                _buildNavItem(
                  context,
                  3,
                  Icons.person_outline,
                  Icons.person,
                  AppLocalizations.of(context)!.navProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    final isSelected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.diagonal3Values(
                isSelected ? 1.1 : 1.0,
                isSelected ? 1.1 : 1.0,
                1.0,
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                size: 24,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              margin: const EdgeInsets.only(top: 4),
              width: isSelected ? 4 : 0,
              height: isSelected ? 4 : 0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
