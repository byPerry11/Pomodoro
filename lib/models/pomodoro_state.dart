import 'timer_config.dart';

enum PomodoroPhase {
  focus,
  shortBreak,
  longBreak,
}

class PomodoroState {
  final int remainingSeconds;
  final PomodoroPhase phase;
  final bool isRunning;
  final int completedPomodoros;
  final TimerConfig config;

  const PomodoroState({
    required this.remainingSeconds,
    required this.phase,
    required this.isRunning,
    required this.completedPomodoros,
    required this.config,
  });

  PomodoroState copyWith({
    int? remainingSeconds,
    PomodoroPhase? phase,
    bool? isRunning,
    int? completedPomodoros,
    TimerConfig? config,
  }) {
    return PomodoroState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      phase: phase ?? this.phase,
      isRunning: isRunning ?? this.isRunning,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      config: config ?? this.config,
    );
  }

  int get totalSeconds {
    switch (phase) {
      case PomodoroPhase.focus:
        return config.focusMinutes * 60;
      case PomodoroPhase.shortBreak:
        return config.breakMinutes * 60;
      case PomodoroPhase.longBreak:
        return config.breakMinutes * 60 * 2; // Double break time
    }
  }

  double get progress {
    if (totalSeconds == 0) return 0.0;
    return (totalSeconds - remainingSeconds) / totalSeconds;
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get phaseName {
    switch (phase) {
      case PomodoroPhase.focus:
        return 'FOCUS';
      case PomodoroPhase.shortBreak:
        return 'BREAK';
      case PomodoroPhase.longBreak:
        return 'LONG BREAK';
    }
  }
}
