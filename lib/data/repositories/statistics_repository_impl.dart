import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/session_history.dart' as domain;
import '../../domain/repositories/statistics_repository.dart';
import '../models/session_history_model.dart' as data;

@LazySingleton(as: StatisticsRepository)
class StatisticsRepositoryImpl implements StatisticsRepository {
  final Isar _isar;

  StatisticsRepositoryImpl(this._isar);

  @override
  Future<void> saveSession(domain.SessionHistory session) async {
    final model = data.SessionHistoryModel()
      ..startTime = session.startTime
      ..durationSeconds = session.durationSeconds
      ..type = _mapTypeToData(session.type)
      ..endedAt = session.endedAt;

    await _isar.writeTxn(() async {
      await _isar.collection<data.SessionHistoryModel>().put(model);
    });
  }

  @override
  Future<List<domain.SessionHistory>> getSessions(
      DateTime start, DateTime end) async {
    final models = await _isar
        .collection<data.SessionHistoryModel>()
        .filter()
        .startTimeBetween(start, end)
        .findAll();

    return models.map((m) => _toDomain(m)).toList();
  }

  data.SessionType _mapTypeToData(domain.SessionType type) {
    switch (type) {
      case domain.SessionType.focus:
        return data.SessionType.focus;
      case domain.SessionType.shortBreak:
        return data.SessionType.shortBreak;
      case domain.SessionType.longBreak:
        return data.SessionType.longBreak;
    }
  }

  domain.SessionType _mapTypeToDomain(data.SessionType type) {
    switch (type) {
      case data.SessionType.focus:
        return domain.SessionType.focus;
      case data.SessionType.shortBreak:
        return domain.SessionType.shortBreak;
      case data.SessionType.longBreak:
        return domain.SessionType.longBreak;
    }
  }

  domain.SessionHistory _toDomain(data.SessionHistoryModel model) {
    return domain.SessionHistory(
      id: model.id.toString(),
      startTime: model.startTime,
      durationSeconds: model.durationSeconds,
      type: _mapTypeToDomain(model.type),
      endedAt: model.endedAt,
    );
  }
}
