import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/settings_usecases.dart';
import '../../domain/usecases/user_usecases.dart';

@lazySingleton
class SettingsService extends ChangeNotifier {
  // Use cases
  final GetNotificationsEnabled _getNotifications;
  final SetNotificationsEnabled _setNotifications;
  final GetSoundEnabled _getSound;
  final SetSoundEnabled _setSound;
  final GetDarkMode _getDarkMode;
  final SetDarkMode _setDarkMode;
  final GetLocale _getLocale;

  final SetLocale _setLocale;
  final GetUserName _getUserName;
  final SetUserName _setUserName;

  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  ThemeMode _themeMode = ThemeMode.system;

  Locale? _locale;
  String? _userName;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  ThemeMode get themeMode => _themeMode;

  Locale? get locale => _locale;
  String? get userName => _userName;

  SettingsService(
    this._getNotifications,
    this._setNotifications,
    this._getSound,
    this._setSound,
    this._getDarkMode,
    this._setDarkMode,
    this._getLocale,
    this._setLocale,
    this._getUserName,
    this._setUserName,
  ) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _notificationsEnabled = await _getNotifications();
    _soundEnabled = await _getSound();

    final isDark = await _getDarkMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    _locale = await _getLocale();
    _userName = await _getUserName();

    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _setNotifications(value);
  }

  Future<void> setSoundEnabled(bool value) async {
    _soundEnabled = value;
    notifyListeners();
    await _setSound(value);
  }

  Future<void> toggleTheme() async {
    final isDark = _themeMode == ThemeMode.dark;
    await setDarkMode(!isDark);
  }

  Future<void> setDarkMode(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _setDarkMode(isDark);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _setDarkMode(mode == ThemeMode.dark);
  }

  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();
    await _setLocale(locale);
  }

  Future<void> setUserName(String? name) async {
    _userName = name;
    notifyListeners();
    await _setUserName(name);
  }
}
