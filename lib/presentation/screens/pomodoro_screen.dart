import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../providers/pomodoro_service.dart';
import '../../domain/entities/timer_config.dart';
import '../widgets/timer_display.dart';
import '../widgets/custom_timer_dialog.dart';
import '../widgets/music_selection_dialog.dart';
import '../providers/music_service.dart';

/// Pantalla principal del timer Pomodoro.
/// Muestra el timer actual, permite seleccionar/configurar timers y muestra estadísticas.
class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PomodoroService>().addListener(_handleError);
    });
  }

  @override
  void dispose() {
    context.read<PomodoroService>().removeListener(_handleError);
    super.dispose();
  }

  void _handleError() {
    final service = context.read<PomodoroService>();
    if (service.state.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(service.state.error!),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      service.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PomodoroService>(
        builder: (context, pomodoroService, child) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              child: Stack(
                children: [
                  // Main content - centered timer
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Timer display
                        TimerDisplay(
                          state: pomodoroService.state,
                          onStart: pomodoroService.startTimer,
                          onPause: pomodoroService.pauseTimer,
                          onReset: pomodoroService.resetTimer,
                        ),

                        const SizedBox(height: 40),

                        // Cycle counter
                        _buildCycleCounter(
                          context,
                          pomodoroService.state.completedPomodoros,
                        ),
                      ],
                    ),
                  ),

                  // Top-right buttons
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Row(
                      children: [
                        // Music button
                        Consumer<MusicService>(
                          builder: (context, musicService, child) {
                            return _buildTopButton(
                              context,
                              musicService.selectedTrack != null
                                  ? Icons.music_note
                                  : Icons.music_note_outlined,
                              () => _showMusicDialog(context),
                              isActive: musicService.isPlaying,
                            );
                          },
                        ),
                        const SizedBox(width: 12),

                        // Settings button
                        _buildTopButton(
                          context,
                          Icons.settings_outlined,
                          () => _showConfigDialog(context),
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

  /// Construye un botón pequeño para la parte superior
  Widget _buildTopButton(
    BuildContext context,
    IconData icon,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            width: isActive ? 1.0 : 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          size: 20,
        ),
      ),
    );
  }

  void _showMusicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const MusicSelectionDialog(),
    );
  }

  /// Construye el contador de ciclos completados hoy
  Widget _buildCycleCounter(BuildContext context, int completedCycles) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.secondary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            l10n.cyclesToday(completedCycles),
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Muestra el diálogo de selección de timer.
  /// Lista todos los timers disponibles (presets + personalizados) y permite crear uno nuevo.
  /// Usa Consumer para ser reactivo y mostrar los nuevos timers cuando se agregan.
  void _showConfigDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => Consumer<PomodoroService>(
        builder: (context, pomodoroService, child) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 0.5,
              ),
            ),
            title: Text(
              l10n.timerConfigTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lista todas las configuraciones disponibles (presets + personalizadas)
                  ...pomodoroService.allConfigs.map(
                    (config) => _buildConfigOption(
                      context,
                      config,
                      config.name,
                      '${config.focusMinutes}min ${l10n.focusDisplay} / ${config.breakMinutes}min ${l10n.breakDisplay}',
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 16),

                  // Opción para crear un nuevo timer personalizado
                  _buildConfigOption(
                    context,
                    null,
                    l10n.timerCustom,
                    l10n.timerCustomDesc,
                    isCustom: true,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  l10n.cancelButton,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Construye una opción de configuración de timer en el diálogo.
  /// Si [isCustom] es true, muestra la opción para crear un nuevo timer personalizado.
  /// Si [config] no es null, muestra una configuración existente para seleccionar.
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
          if (isCustom) {
            // Obtiene el servicio antes de mostrar el diálogo anidado
            // para asegurar que el contexto sea correcto
            final service = context.read<PomodoroService>();
            // Muestra el diálogo para crear un timer personalizado
            final result = await showDialog<TimerConfig>(
              context: context,
              builder: (context) => const CustomTimerDialog(),
            );

            if (result != null) {
              // Agrega la configuración personalizada y obtiene el config guardado
              // (puede tener nombre único si había duplicados)
              final savedConfig = await service.addCustomConfig(result);

              if (savedConfig != null) {
                // Actualiza el timer para usar la configuración guardada
                service.updateConfig(savedConfig);

                // Cierra el diálogo principal usando rootNavigator
                // para evitar conflictos con diálogos anidados
                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              }
            }
          } else if (config != null) {
            // Si es una configuración existente, simplemente la selecciona
            context.read<PomodoroService>().updateConfig(config);
            Navigator.of(context).pop();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        tileColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          isCustom ? Icons.add : Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.secondary,
          size: 16,
        ),
      ),
    );
  }
}
