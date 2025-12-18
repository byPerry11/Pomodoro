import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../providers/pomodoro_service.dart';
import '../providers/task_service.dart';
import '../providers/settings_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              Text(
                l10n.navProfile,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 32),

              // Estadísticas
              _buildStatsSection(context, l10n),

              const SizedBox(height: 32),

              // Configuración
              _buildSettingsSection(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, AppLocalizations l10n) {
    return Consumer2<PomodoroService, TaskService>(
      builder: (context, pomodoroService, taskService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.statsTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            // Stats cards
            _buildStatCard(
              context,
              l10n.statsPomodoros,
              '${pomodoroService.state.completedPomodoros}',
              Icons.timer,
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              l10n.statsCompletedTasks,
              '${taskService.completedTasks.length}',
              Icons.check_circle_outline,
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context,
              l10n.statsPendingTasks,
              '${taskService.pendingTasks.length}',
              Icons.pending_outlined,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, AppLocalizations l10n) {
    return Consumer<SettingsService>(
      builder: (context, settingsService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              context,
              l10n.settingsNotifications,
              l10n.settingsNotificationsDesc,
              Icons.notifications_outlined,
              settingsService.notificationsEnabled,
              (value) => settingsService.setNotificationsEnabled(value),
            ),
            const SizedBox(height: 12),
            _buildSettingItem(
              context,
              l10n.settingsSound,
              l10n.settingsSoundDesc,
              Icons.volume_up_outlined,
              settingsService.soundEnabled,
              (value) => settingsService.setSoundEnabled(value),
            ),
            const SizedBox(height: 12),
            _buildThemeSelector(context, settingsService, l10n),
          ],
        );
      },
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    SettingsService settingsService,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.dark_mode_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsTheme,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  _getThemeModeLabel(l10n, settingsService.themeMode),
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<ThemeMode>(
            value: settingsService.themeMode,
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.secondary,
            ),
            items: [
              _buildThemeMenuItem(
                context,
                ThemeMode.system,
                l10n.themeSystemShort,
              ),
              _buildThemeMenuItem(
                context,
                ThemeMode.light,
                l10n.themeLightShort,
              ),
              _buildThemeMenuItem(context, ThemeMode.dark, l10n.themeDarkShort),
            ],
            onChanged: (mode) {
              if (mode != null) settingsService.setThemeMode(mode);
            },
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<ThemeMode> _buildThemeMenuItem(
    BuildContext context,
    ThemeMode mode,
    String label,
  ) {
    return DropdownMenuItem(
      value: mode,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  String _getThemeModeLabel(AppLocalizations l10n, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.themeSystem;
      case ThemeMode.light:
        return l10n.themeLight;
      case ThemeMode.dark:
        return l10n.themeDark;
    }
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
