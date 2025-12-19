import '../entities/session_history.dart';

abstract class StatisticsRepository {
  Future<void> saveSession(SessionHistory session);
  Future<List<SessionHistory>> getSessions(DateTime start, DateTime end);
}
