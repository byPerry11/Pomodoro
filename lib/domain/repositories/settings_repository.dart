import 'dart:ui';

abstract class SettingsRepository {
  Future<bool> isSoundEnabled();
  Future<void> setSoundEnabled(bool enabled);

  Future<bool> areNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool enabled);

  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool enabled);

  Future<Locale?> getLocale();
  Future<void> setLocale(Locale? locale);

  Future<String?> getUserName();
  Future<void> setUserName(String? name);
}
