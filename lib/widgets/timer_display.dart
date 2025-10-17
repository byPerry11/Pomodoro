import 'package:flutter/material.dart';
import '../models/pomodoro_state.dart';

class TimerDisplay extends StatelessWidget {
  final PomodoroState state;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const TimerDisplay({
    super.key,
    required this.state,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Phase indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF00FF41), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            state.phaseName,
            style: const TextStyle(
              color: Color(0xFF00FF41),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier',
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 40),
        
        // Progress ring
        SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF333333),
                    width: 8,
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 280,
                height: 280,
                child: CircularProgressIndicator(
                  value: state.progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    state.phase == PomodoroPhase.focus
                        ? const Color(0xFF00FF41)
                        : const Color(0xFFFF6B35),
                  ),
                ),
              ),
              // Timer text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.formattedTime,
                    style: const TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.config.focusMinutes}/${state.config.breakMinutes}',
                    style: TextStyle(
                      color: const Color(0xFF00FF41).withOpacity(0.7),
                      fontSize: 14,
                      fontFamily: 'Courier',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Start/Pause button
            GestureDetector(
              onTap: state.isRunning ? onPause : onStart,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.isRunning 
                      ? const Color(0xFFFF6B35)
                      : const Color(0xFF00FF41),
                  boxShadow: [
                    BoxShadow(
                      color: (state.isRunning 
                          ? const Color(0xFFFF6B35)
                          : const Color(0xFF00FF41)).withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  state.isRunning ? Icons.pause : Icons.play_arrow,
                  color: const Color(0xFF0A0A0A),
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 40),
            
            // Reset button
            GestureDetector(
              onTap: onReset,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF666666), width: 2),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Color(0xFF666666),
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        
        // Completed pomodoros
        if (state.completedPomodoros > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              border: Border.all(color: const Color(0xFF00FF41)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'COMPLETED: ${state.completedPomodoros}',
              style: const TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
                letterSpacing: 1,
              ),
            ),
          ),
      ],
    );
  }
}
