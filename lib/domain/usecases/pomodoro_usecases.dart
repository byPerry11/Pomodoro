import 'package:injectable/injectable.dart';
import '../entities/timer_config.dart';
import '../repositories/pomodoro_repository.dart';

@injectable
class GetCustomTimerConfigs {
  final PomodoroRepository repository;
  GetCustomTimerConfigs(this.repository);
  Future<List<TimerConfig>> call() => repository.getCustomConfigs();
}

@injectable
class SaveTimerConfig {
  final PomodoroRepository repository;
  SaveTimerConfig(this.repository);
  Future<void> call(TimerConfig config) => repository.saveCustomConfig(config);
}

@injectable
class DeleteTimerConfig {
  final PomodoroRepository repository;
  DeleteTimerConfig(this.repository);
  Future<void> call(TimerConfig config) =>
      repository.deleteCustomConfig(config);
}
