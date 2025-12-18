import 'package:injectable/injectable.dart';
import '../repositories/settings_repository.dart';

@injectable
class GetSoundEnabled {
  final SettingsRepository repository;
  GetSoundEnabled(this.repository);
  Future<bool> call() => repository.isSoundEnabled();
}

@injectable
class SetSoundEnabled {
  final SettingsRepository repository;
  SetSoundEnabled(this.repository);
  Future<void> call(bool enabled) => repository.setSoundEnabled(enabled);
}

@injectable
class GetNotificationsEnabled {
  final SettingsRepository repository;
  GetNotificationsEnabled(this.repository);
  Future<bool> call() => repository.areNotificationsEnabled();
}

@injectable
class SetNotificationsEnabled {
  final SettingsRepository repository;
  SetNotificationsEnabled(this.repository);
  Future<void> call(bool enabled) =>
      repository.setNotificationsEnabled(enabled);
}

@injectable
class GetDarkMode {
  final SettingsRepository repository;
  GetDarkMode(this.repository);
  Future<bool> call() => repository.isDarkMode();
}

@injectable
class SetDarkMode {
  final SettingsRepository repository;
  SetDarkMode(this.repository);
  Future<void> call(bool enabled) => repository.setDarkMode(enabled);
}
