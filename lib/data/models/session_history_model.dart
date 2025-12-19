import 'package:isar/isar.dart';

part 'session_history_model.g.dart';

@collection
class SessionHistoryModel {
  Id id = Isar.autoIncrement;

  late DateTime startTime;

  late int durationSeconds;

  @enumerated
  late SessionType type;

  DateTime? endedAt;
}

enum SessionType {
  focus,
  shortBreak,
  longBreak,
}
