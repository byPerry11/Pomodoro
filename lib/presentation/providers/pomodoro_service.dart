import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';
import '../../domain/entities/pomodoro_state.dart';
import '../../domain/entities/timer_config.dart';
import '../../domain/usecases/pomodoro_usecases.dart';
import 'notification_service.dart';
import 'settings_service.dart';
import 'music_service.dart';

@lazySingleton
class PomodoroService extends ChangeNotifier {
  final GetCustomTimerConfigs _getCustomConfigs;
  final SaveTimerConfig _saveConfig;
  final DeleteTimerConfig _deleteConfig;

  // Dependencies
  final SettingsService _settings;
  final MusicService _music;

  PomodoroState _state = PomodoroState(
    remainingSeconds: TimerConfig.presets.first.focusMinutes * 60,
    phase: PomodoroPhase.focus,
    isRunning: false,
    completedPomodoros: 0,
    config: TimerConfig.presets.first,
  );

  Timer? _timer;
  List<TimerConfig> _customConfigs = [];

  PomodoroService(
    this._getCustomConfigs,
    this._saveConfig,
    this._deleteConfig,
    this._settings,
    this._music,
  ) {
    _loadCustomConfigs();
  }

  // Removed updateDependencies

  PomodoroState get state => _state;
  List<TimerConfig> get customConfigs => _customConfigs;
  List<TimerConfig> get allConfigs =>
      [...TimerConfig.presets, ..._customConfigs];

  Future<void> _loadCustomConfigs() async {
    _customConfigs = await _getCustomConfigs();
    notifyListeners();
  }

  void startTimer() {
    if (_state.isRunning) return;

    _state = _state.copyWith(isRunning: true);
    notifyListeners();
    NotificationService.playTimerStartSound(_settings.soundEnabled);

    if (_settings.soundEnabled) {
      _music.play();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.remainingSeconds > 0) {
        _state = _state.copyWith(remainingSeconds: _state.remainingSeconds - 1);
        notifyListeners();
      } else {
        _completePhase();
      }
    });
  }

  void pauseTimer() {
    if (!_state.isRunning) return;

    _timer?.cancel();
    _state = _state.copyWith(isRunning: false);
    notifyListeners();
    NotificationService.playTimerPauseSound(_settings.soundEnabled);
    _music.stop();
  }

  void resetTimer() {
    _timer?.cancel();
    _state = PomodoroState(
      remainingSeconds: _state.config.focusMinutes * 60,
      phase: PomodoroPhase.focus,
      isRunning: false,
      completedPomodoros: 0,
      config: _state.config,
    );
    notifyListeners();
  }

  void updateConfig(TimerConfig config) {
    _timer?.cancel();
    _state = PomodoroState(
      remainingSeconds: config.focusMinutes * 60,
      phase: PomodoroPhase.focus,
      isRunning: false,
      completedPomodoros: 0,
      config: config,
    );
    notifyListeners();
  }

  Future<TimerConfig?> addCustomConfig(TimerConfig config) async {
    // Generate unique name
    String uniqueName = config.name;
    int counter = 1;
    while (_customConfigs.any((c) => c.name == uniqueName)) {
      uniqueName = '${config.name} $counter';
      counter++;
    }

    final uniqueConfig = uniqueName != config.name
        ? TimerConfig(
            focusMinutes: config.focusMinutes,
            breakMinutes: config.breakMinutes,
            name: uniqueName,
          )
        : config;

    // Save
    await _saveConfig(uniqueConfig);

    // Reload
    await _loadCustomConfigs();

    try {
      return _customConfigs.firstWhere((c) => c.name == uniqueConfig.name);
    } catch (_) {
      return uniqueConfig;
    }
  }

  Future<void> deleteCustomConfig(TimerConfig config) async {
    await _deleteConfig(config);
    await _loadCustomConfigs();
  }

  void _completePhase() {
    _timer?.cancel();

    switch (_state.phase) {
      case PomodoroPhase.focus:
        final nextCompletedCount = _state.completedPomodoros + 1;
        final isLongBreak = nextCompletedCount % 4 == 0;
        _state = _state.copyWith(
          completedPomodoros: nextCompletedCount,
          phase:
              isLongBreak ? PomodoroPhase.longBreak : PomodoroPhase.shortBreak,
          remainingSeconds: isLongBreak
              ? _state.config.breakMinutes * 60 * 2
              : _state.config.breakMinutes * 60,
          isRunning: false,
        );
        NotificationService.playFocusCompleteSound(_settings.soundEnabled);

        startTimer();
        break;
      case PomodoroPhase.shortBreak:
      case PomodoroPhase.longBreak:
        _state = _state.copyWith(
          phase: PomodoroPhase.focus,
          remainingSeconds: _state.config.focusMinutes * 60,
          isRunning: false,
        );
        NotificationService.playBreakCompleteSound(_settings.soundEnabled);

        _music.stop();
        break;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
