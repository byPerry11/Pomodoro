import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/pomodoro_service.dart';
import '../models/timer_config.dart';
import '../widgets/timer_display.dart';
import '../widgets/custom_timer_dialog.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PomodoroService(),
      child: const _PomodoroScreenContent(),
    );
  }
}

class _PomodoroScreenContent extends StatelessWidget {
  const _PomodoroScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POMODORO TIMER',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showConfigDialog(context),
            icon: const Icon(Icons.settings),
            tooltip: 'Timer Settings',
          ),
        ],
      ),
      body: Consumer<PomodoroService>(
        builder: (context, pomodoroService, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Color(0xFF0A0A0A),
                  Color(0xFF1A1A1A),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Timer configuration selector
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      border: Border.all(color: const Color(0xFF333333)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Color(0xFF00FF41),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            pomodoroService.state.config.name,
                            style: const TextStyle(
                              color: Color(0xFF00FF41),
                              fontSize: 16,
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showConfigDialog(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF00FF41)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'CHANGE',
                              style: TextStyle(
                                color: Color(0xFF00FF41),
                                fontSize: 12,
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Main timer display
                  Expanded(
                    child: Center(
                      child: TimerDisplay(
                        state: pomodoroService.state,
                        onStart: pomodoroService.startTimer,
                        onPause: pomodoroService.pauseTimer,
                        onReset: pomodoroService.resetTimer,
                      ),
                    ),
                  ),
                  
                  // Bottom info
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      border: Border.all(color: const Color(0xFF333333)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoItem(
                          'FOCUS',
                          '${pomodoroService.state.config.focusMinutes}m',
                          const Color(0xFF00FF41),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: const Color(0xFF333333),
                        ),
                        _buildInfoItem(
                          'BREAK',
                          '${pomodoroService.state.config.breakMinutes}m',
                          const Color(0xFFFF6B35),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: const Color(0xFF333333),
                        ),
                        _buildInfoItem(
                          'COMPLETED',
                          '${pomodoroService.state.completedPomodoros}',
                          const Color(0xFF00FF41),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.7),
            fontSize: 12,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showConfigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF00FF41), width: 2),
        ),
        title: const Text(
          'SELECT TIMER',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Preset configurations
            ...TimerConfig.presets.map((config) => _buildConfigOption(
              context,
              config,
              config.name,
              '${config.focusMinutes}min focus / ${config.breakMinutes}min break',
            )),
            
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF333333)),
            const SizedBox(height: 16),
            
            // Custom timer option
            _buildConfigOption(
              context,
              null,
              'CUSTOM TIMER',
              'Create your own focus/break intervals',
              isCustom: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                color: Color(0xFF666666),
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigOption(
    BuildContext context,
    TimerConfig? config,
    String title,
    String subtitle, {
    bool isCustom = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () async {
          Navigator.of(context).pop();
          
          if (isCustom) {
            final result = await showDialog<TimerConfig>(
              context: context,
              builder: (context) => const CustomTimerDialog(),
            );
            
            if (result != null) {
              context.read<PomodoroService>().updateConfig(result);
            }
          } else if (config != null) {
            context.read<PomodoroService>().updateConfig(config);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFF333333)),
        ),
        tileColor: const Color(0xFF0A0A0A),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF00FF41),
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: const Color(0xFF00FF41).withOpacity(0.7),
            fontFamily: 'Courier',
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          isCustom ? Icons.add : Icons.arrow_forward_ios,
          color: const Color(0xFF00FF41),
          size: 16,
        ),
      ),
    );
  }
}
