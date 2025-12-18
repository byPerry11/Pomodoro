import '../entities/timer_config.dart';

abstract class PomodoroRepository {
  Future<List<TimerConfig>> getCustomConfigs();
  Future<void> saveCustomConfig(TimerConfig config);
  Future<void> deleteCustomConfig(TimerConfig config);
}
