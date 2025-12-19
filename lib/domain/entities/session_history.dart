enum SessionType {
  focus,
  shortBreak,
  longBreak,
}

class SessionHistory {
  final String id;
  final DateTime startTime;
  final int durationSeconds;
  final SessionType type;
  final DateTime? endedAt;

  SessionHistory({
    required this.id,
    required this.startTime,
    required this.durationSeconds,
    required this.type,
    this.endedAt,
  });
}
