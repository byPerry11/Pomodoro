import 'dart:ui';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/settings_model.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final Isar _isar;

  SettingsRepositoryImpl(this._isar);

  Future<SettingsModel> _getSettings() async {
    // Try to find the single settings row
    final settings = await _isar
        .collection<SettingsModel>()
        .where()
        .keyEqualTo('user_settings')
        .findFirst();

    if (settings != null) return settings;

    // Create default if not exists
    final newSettings = SettingsModel()..key = 'user_settings';
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(newSettings);
    });
    return newSettings;
  }

  @override
  Future<bool> isSoundEnabled() async {
    final settings = await _getSettings();
    return settings.soundEnabled;
  }

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    final settings = await _getSettings();
    settings.soundEnabled = enabled;
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(settings);
    });
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    final settings = await _getSettings();
    return settings.notificationsEnabled;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    final settings = await _getSettings();
    settings.notificationsEnabled = enabled;
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(settings);
    });
  }

  @override
  Future<bool> isDarkMode() async {
    final settings = await _getSettings();
    return settings.isDarkMode;
  }

  @override
  Future<void> setDarkMode(bool enabled) async {
    final settings = await _getSettings();
    settings.isDarkMode = enabled;
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(settings);
    });
  }

  @override
  Future<Locale?> getLocale() async {
    final settings = await _getSettings();
    if (settings.localeCode != null) {
      return Locale(settings.localeCode!);
    }
    return null;
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    final settings = await _getSettings();
    settings.localeCode = locale?.languageCode;
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(settings);
    });
  }

  @override
  Future<String?> getUserName() async {
    final settings = await _getSettings();
    return settings.userName;
  }

  @override
  Future<void> setUserName(String? name) async {
    final settings = await _getSettings();
    settings.userName = name;
    await _isar.writeTxn(() async {
      await _isar.collection<SettingsModel>().put(settings);
    });
  }
}
