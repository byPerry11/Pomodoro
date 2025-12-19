import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/domain/entities/pomodoro_state.dart';
import 'package:pomodoro_app/domain/entities/timer_config.dart';
import 'package:pomodoro_app/presentation/widgets/timer_display.dart';

void main() {
  testWidgets('TimerDisplay renders correct time format',
      (WidgetTester tester) async {
    // Helper to create state
    PomodoroState createState(int seconds) {
      return PomodoroState(
        remainingSeconds: seconds,
        phase: PomodoroPhase.focus,
        isRunning: false,
        completedPomodoros: 0,
        config: TimerConfig.presets.first,
        error: null,
      );
    }

    // Test case 1: 0 seconds (00:00)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimerDisplay(
            state: createState(0),
            onStart: () {},
            onPause: () {},
            onReset: () {},
          ),
        ),
      ),
    );

    expect(find.text('00:00'), findsOneWidget);

    // Test case 2: 25 minutes (25:00)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimerDisplay(
            state: createState(25 * 60),
            onStart: () {},
            onPause: () {},
            onReset: () {},
          ),
        ),
      ),
    );

    expect(find.text('25:00'), findsOneWidget);

    // Test case 3: 59 seconds (00:59)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimerDisplay(
            state: createState(59),
            onStart: () {},
            onPause: () {},
            onReset: () {},
          ),
        ),
      ),
    );

    expect(find.text('00:59'), findsOneWidget);
  });
}
