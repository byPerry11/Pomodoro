import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../providers/settings_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: Consumer<SettingsService>(
        builder: (context, settingsService, child) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSectionTitle(context, 'Preferences'), // l10n.settingsTitle
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
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Appearance'),
              const SizedBox(height: 16),
              _buildThemeSelector(context, settingsService, l10n),
              const SizedBox(height: 12),
              _buildLanguageSelector(context, settingsService, l10n),
              const SizedBox(height: 32),
              _buildAboutSection(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1.0,
      ),
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

  Widget _buildLanguageSelector(
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
            Icons.language,
            color: Theme.of(context).colorScheme.secondary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  _getLanguageLabel(settingsService.locale?.languageCode),
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: settingsService.locale?.languageCode ?? 'en',
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.secondary,
            ),
            items: [
              _buildLanguageMenuItem(context, 'en', 'English'),
              _buildLanguageMenuItem(context, 'es', 'Español'),
            ],
            onChanged: (code) {
              if (code != null) settingsService.setLocale(Locale(code));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Icon(
          Icons.access_time_filled,
          size: 48,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          'Pomodoro App',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Version 1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  // Reuse helper methods from ProfileScreen (copied over)

  DropdownMenuItem<String> _buildLanguageMenuItem(
    BuildContext context,
    String code,
    String label,
  ) {
    return DropdownMenuItem(
      value: code,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  String _getLanguageLabel(String? code) {
    switch (code) {
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
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
