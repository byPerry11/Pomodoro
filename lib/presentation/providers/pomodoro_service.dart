import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';
import '../../domain/entities/pomodoro_state.dart';
import '../../domain/entities/timer_config.dart';
import '../../domain/entities/session_history.dart';
import '../../domain/usecases/pomodoro_usecases.dart';
import '../../domain/usecases/statistics_usecases.dart';
import 'notification_service.dart';
import 'settings_service.dart';
import 'music_service.dart';

@lazySingleton
class PomodoroService extends ChangeNotifier {
  final GetCustomTimerConfigs _getCustomConfigs;
  final SaveTimerConfig _saveConfig;
  final DeleteTimerConfig _deleteConfig;
  final SaveSession _saveSession;

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
  DateTime? _currentSessionStartTime;
  List<TimerConfig> _customConfigs = [];

  PomodoroService(
    this._getCustomConfigs,
    this._saveConfig,
    this._deleteConfig,
    this._saveSession,
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

  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }

  Future<void> _loadCustomConfigs() async {
    try {
      _customConfigs = await _getCustomConfigs();
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to load configs: $e');
    } finally {
      notifyListeners();
    }
  }

  void startTimer() {
    if (_state.isRunning) return;

    // Track start time if resuming or starting fresh
    _currentSessionStartTime ??= DateTime.now();

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
    _currentSessionStartTime = null;
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
    _currentSessionStartTime = null;
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
    try {
      await _saveConfig(uniqueConfig);
      // Reload
      await _loadCustomConfigs();

      try {
        return _customConfigs.firstWhere((c) => c.name == uniqueConfig.name);
      } catch (_) {
        return uniqueConfig;
      }
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to save config: $e');
      notifyListeners();
      return null;
    }
  }

  Future<void> deleteCustomConfig(TimerConfig config) async {
    try {
      await _deleteConfig(config);
      await _loadCustomConfigs();
    } catch (e) {
      _state = _state.copyWith(error: 'Failed to delete config: $e');
      notifyListeners();
    }
  }

  void _completePhase() {
    _timer?.cancel();
    final now = DateTime.now();

    // Save session history
    if (_currentSessionStartTime != null) {
      final duration = now.difference(_currentSessionStartTime!).inSeconds;
      // Filter out accidental clicks (less than 10 seconds? or just save everything?)
      // For now, save if > 0.
      if (duration > 0) {
        _logSession(_state.phase, _currentSessionStartTime!, duration, now);
      }
    }
    _currentSessionStartTime = null;

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
        NotificationService.showNotification(
          title: 'Pomodoro Completed!',
          body: isLongBreak
              ? 'Great job! Take a long break.'
              : 'Focus session done. Take a short break.',
        );

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
        NotificationService.showNotification(
          title: 'Break Over!',
          body: 'Time to focus again.',
        );

        _music.stop();
        break;
    }

    notifyListeners();
  }

  Future<void> _logSession(
      PomodoroPhase phase, DateTime start, int duration, DateTime end) async {
    try {
      await _saveSession(SessionHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        startTime: start,
        durationSeconds: duration,
        type: _mapPhaseToSessionType(phase),
        endedAt: end,
      ));
    } catch (e) {
      print('Error saving session: $e');
      // Don't disrupt UI for logging error
    }
  }

  SessionType _mapPhaseToSessionType(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.focus:
        return SessionType.focus;
      case PomodoroPhase.shortBreak:
        return SessionType.shortBreak;
      case PomodoroPhase.longBreak:
        return SessionType.longBreak;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
