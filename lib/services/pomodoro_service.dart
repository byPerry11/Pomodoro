import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/pomodoro_state.dart';
import '../models/timer_config.dart';
import 'notification_service.dart';

class PomodoroService extends ChangeNotifier {
  PomodoroState _state = PomodoroState(
    remainingSeconds: TimerConfig.presets.first.focusMinutes * 60,
    phase: PomodoroPhase.focus,
    isRunning: false,
    completedPomodoros: 0,
    config: TimerConfig.presets.first,
  );

  Timer? _timer;

  PomodoroState get state => _state;

  void startTimer() {
    if (_state.isRunning) return;
    
    _state = _state.copyWith(isRunning: true);
    notifyListeners();
    NotificationService.playTimerStartSound();

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
    NotificationService.playTimerPauseSound();
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

  void _completePhase() {
    _timer?.cancel();
    
    switch (_state.phase) {
      case PomodoroPhase.focus:
        _state = _state.copyWith(
          completedPomodoros: _state.completedPomodoros + 1,
          phase: _state.completedPomodoros % 3 == 0 
              ? PomodoroPhase.longBreak 
              : PomodoroPhase.shortBreak,
          remainingSeconds: _state.completedPomodoros % 3 == 0
              ? _state.config.breakMinutes * 60 * 2
              : _state.config.breakMinutes * 60,
          isRunning: false,
        );
        NotificationService.playFocusCompleteSound();
        break;
      case PomodoroPhase.shortBreak:
      case PomodoroPhase.longBreak:
        _state = _state.copyWith(
          phase: PomodoroPhase.focus,
          remainingSeconds: _state.config.focusMinutes * 60,
          isRunning: false,
        );
        NotificationService.playBreakCompleteSound();
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
