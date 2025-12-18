import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/timer_config.dart';
import '../../domain/repositories/pomodoro_repository.dart';
import '../models/timer_config_model.dart';

@LazySingleton(as: PomodoroRepository)
class PomodoroRepositoryImpl implements PomodoroRepository {
  final Isar _isar;

  PomodoroRepositoryImpl(this._isar);

  @override
  Future<List<TimerConfig>> getCustomConfigs() async {
    final models = await _isar.collection<TimerConfigModel>().where().findAll();
    return models.map((model) => _toDomain(model)).toList();
  }

  @override
  Future<void> saveCustomConfig(TimerConfig config) async {
    final model = _toData(config);
    // Ensure we mark it as custom
    model.isCustom = true;
    await _isar.writeTxn(() async {
      await _isar.collection<TimerConfigModel>().put(model);
    });
  }

  @override
  Future<void> deleteCustomConfig(TimerConfig config) async {
    if (config.id != null) {
      final id = int.tryParse(config.id!);
      if (id != null) {
        await _isar.writeTxn(() async {
          await _isar.collection<TimerConfigModel>().delete(id);
        });
      }
    }
  }

  // Mappers (Kept same logic)

  TimerConfig _toDomain(TimerConfigModel model) {
    return TimerConfig(
      id: model.id.toString(),
      name: model.name,
      focusMinutes: model.focusMinutes,
      breakMinutes: model.breakMinutes,
    );
  }

  TimerConfigModel _toData(TimerConfig config) {
    final model = TimerConfigModel()
      ..name = config.name
      ..focusMinutes = config.focusMinutes
      ..breakMinutes = config.breakMinutes
      ..isCustom = true;

    if (config.id != null) {
      final id = int.tryParse(config.id!);
      if (id != null) {
        model.id = id;
      }
    }

    return model;
  }
}
