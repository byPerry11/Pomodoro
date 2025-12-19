import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement;

  bool soundEnabled = true;

  bool notificationsEnabled = true;

  bool isDarkMode = true;

  String? localeCode;

  String? userName;

  @Index(unique: true)
  String key = 'user_settings'; // Singleton key
}
