import 'package:injectable/injectable.dart';
import '../entities/session_history.dart';
import '../repositories/statistics_repository.dart';

@injectable
class SaveSession {
  final StatisticsRepository _repository;

  SaveSession(this._repository);

  Future<void> call(SessionHistory session) {
    return _repository.saveSession(session);
  }
}

@injectable
class GetWeeklyStats {
  final StatisticsRepository _repository;

  GetWeeklyStats(this._repository);

  Future<List<SessionHistory>> call() {
    final now = DateTime.now();
    // Start of 7 days ago (to ensure we get a full week)
    final start = now.subtract(const Duration(days: 7));
    return _repository.getSessions(start, now);
  }
}
