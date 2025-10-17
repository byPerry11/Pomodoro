import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/pomodoro_screen.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Courier',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Color(0xFF00FF41),
          elevation: 0,
        ),
      ),
      home: const PomodoroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
