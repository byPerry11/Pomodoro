@GenerateMocks([
  GetCustomTimerConfigs,
  SaveTimerConfig,
  DeleteTimerConfig,
  SettingsService,
  MusicService,
  SaveSession,
])
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pomodoro_app/domain/entities/timer_config.dart';
import 'package:pomodoro_app/domain/usecases/pomodoro_usecases.dart';
import 'package:pomodoro_app/domain/usecases/statistics_usecases.dart';
import 'package:pomodoro_app/presentation/providers/music_service.dart';
import 'package:pomodoro_app/presentation/providers/pomodoro_service.dart';
import 'package:pomodoro_app/presentation/providers/settings_service.dart';

import 'pomodoro_service_test.mocks.dart';

void main() {
  late PomodoroService pomodoroService;
  late MockGetCustomTimerConfigs mockGetCustomConfigs;
  late MockSaveTimerConfig mockSaveConfig;
  late MockDeleteTimerConfig mockDeleteConfig;
  late MockSettingsService mockSettings;
  late MockMusicService mockMusic;
  late MockSaveSession mockSaveSession;

  setUp(() {
    mockGetCustomConfigs = MockGetCustomTimerConfigs();
    mockSaveConfig = MockSaveTimerConfig();
    mockDeleteConfig = MockDeleteTimerConfig();
    mockSettings = MockSettingsService();
    mockMusic = MockMusicService();
    mockSaveSession = MockSaveSession();

    // Default mock behavior
    when(mockGetCustomConfigs.call()).thenAnswer((_) async => []);
    when(mockSettings.soundEnabled).thenReturn(true);

    pomodoroService = PomodoroService(
      mockGetCustomConfigs,
      mockSaveConfig,
      mockDeleteConfig,
      mockSaveSession,
      mockSettings,
      mockMusic,
    );
  });

  group('PomodoroService Tests', () {
    test('Initial state is correct', () {
      expect(pomodoroService.state.isRunning, false);
      expect(pomodoroService.state.completedPomodoros, 0);
      expect(pomodoroService.state.remainingSeconds, 25 * 60); // Default 25 min
    });

    test('startTimer updates isRunning state', () {
      // Act
      pomodoroService.startTimer();

      // Assert
      expect(pomodoroService.state.isRunning, true);
      verify(mockMusic.play()).called(1);
    });

    test('pauseTimer updates isRunning state', () {
      // Arrange
      pomodoroService.startTimer();

      // Act
      pomodoroService.pauseTimer();

      // Assert
      expect(pomodoroService.state.isRunning, false);
      verify(mockMusic.stop()).called(1);
    });

    test('resetTimer resets state to config defaults', () {
      // Arrange
      pomodoroService.startTimer();
      // Simulate some time passing by modifying state directly if possible
      // or just assume reset logic works on any state

      // Act
      pomodoroService.resetTimer();

      // Assert
      expect(pomodoroService.state.isRunning, false);
      expect(pomodoroService.state.remainingSeconds,
          pomodoroService.state.config.focusMinutes * 60);
    });

    test('updateConfig changes current config and resets timer', () {
      // Arrange
      const newConfig = TimerConfig(
        name: 'Test',
        focusMinutes: 50,
        breakMinutes: 10,
      );

      // Act
      pomodoroService.updateConfig(newConfig);

      // Assert
      expect(pomodoroService.state.config, newConfig);
      expect(pomodoroService.state.remainingSeconds, 50 * 60);
      expect(pomodoroService.state.isRunning, false);
    });
  });
}
