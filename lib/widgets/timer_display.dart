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
        // Progress ring
        SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 260,
                height: 260,
                child: CircularProgressIndicator(
                  value: state.progress,
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // Timer text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.formattedTime,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 56,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Courier',
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      state.phaseName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontFamily: 'Courier',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Start/Pause button
            GestureDetector(
              onTap: state.isRunning ? onPause : onStart,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  state.isRunning ? Icons.pause : Icons.play_arrow,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 24),
            
            // Reset button
            GestureDetector(
              onTap: onReset,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
