import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/session_history.dart';
import '../../domain/usecases/statistics_usecases.dart';

@injectable
class StatisticsService extends ChangeNotifier {
  final GetWeeklyStats _getWeeklyStats;

  List<SessionHistory> _weeklySessions = [];
  bool _isLoading = false;

  List<SessionHistory> get weeklySessions => _weeklySessions;
  bool get isLoading => _isLoading;

  StatisticsService(this._getWeeklyStats);

  Future<void> loadWeeklyStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      _weeklySessions = await _getWeeklyStats();
    } catch (e) {
      print('Error loading stats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<int, int> get focusMinutesPerDay {
    // 0 = Monday, ... 6 = Sunday
    final Map<int, int> minutesPerDay = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0
    };

    for (final session in _weeklySessions) {
      if (session.type == SessionType.focus) {
        // weekday is 1-7 (Mon-Sun)
        final day = session.startTime.weekday;
        minutesPerDay[day] =
            (minutesPerDay[day] ?? 0) + (session.durationSeconds ~/ 60);
      }
    }
    return minutesPerDay;
  }
}
