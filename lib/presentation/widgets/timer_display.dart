import 'package:flutter/material.dart';
import '../../domain/entities/pomodoro_state.dart';

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
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.15),
                      blurRadius: 40,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Background circle
              SizedBox(
                width: 280,
                height: 280,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.2),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Progress circle
              SizedBox(
                width: 280,
                height: 280,
                child: CircularProgressIndicator(
                  value: state.progress,
                  strokeWidth: 16,
                  backgroundColor: Colors.transparent,
                  color: Theme.of(context).colorScheme.primary,
                  strokeCap: StrokeCap.round,
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
                      fontSize: 64,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      state.phaseName.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 56),

        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Start/Pause button
            GestureDetector(
              onTap: state.isRunning ? onPause : onStart,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Icon(
                  state.isRunning
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(width: 32),

            // Reset button
            GestureDetector(
              onTap: onReset,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
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
