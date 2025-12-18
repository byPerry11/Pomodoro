import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task_model.dart';
import '../models/settings_model.dart';
import '../models/timer_config_model.dart';

class IsarDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskModelSchema, SettingsModelSchema, TimerConfigModelSchema],
      directory: dir.path,
    );
  }

  // Generic helpers
  static Future<void> put<T>(T object) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().put(object);
    });
  }

  static Future<void> delete<T>(Id id) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().delete(id);
    });
  }

  static Future<void> clear<T>() async {
    await isar.writeTxn(() async {
      await isar.collection<T>().clear();
    });
  }
}
