import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pomodoro_state.dart';
import '../models/timer_config.dart';
import 'notification_service.dart';

/// Servicio para gestionar el timer Pomodoro y sus configuraciones.
/// Controla el ciclo de trabajo/descanso y persiste las configuraciones personalizadas.
class PomodoroService extends ChangeNotifier {
  // Estado actual del Pomodoro (tiempo restante, fase, si está corriendo, etc.)
  PomodoroState _state = PomodoroState(
    remainingSeconds: TimerConfig.presets.first.focusMinutes * 60,
    phase: PomodoroPhase.focus,
    isRunning: false,
    completedPomodoros: 0,
    config: TimerConfig.presets.first,
  );

  // Timer que actualiza el contador cada segundo
  Timer? _timer;
  // Lista de configuraciones de timer personalizadas por el usuario
  List<TimerConfig> _customConfigs = [];
  // Clave para almacenar las configuraciones personalizadas en SharedPreferences
  static const String _customConfigsKey = 'pomodoro_custom_configs';

  // Getters públicos
  PomodoroState get state => _state;
  List<TimerConfig> get customConfigs => _customConfigs;
  // Retorna todas las configuraciones: presets + personalizadas
  List<TimerConfig> get allConfigs => [...TimerConfig.presets, ..._customConfigs];

  PomodoroService() {
    // Cargar las configuraciones personalizadas guardadas al inicializar
    _loadCustomConfigs();
  }

  /// Inicia el timer si no está corriendo.
  /// Actualiza el contador cada segundo hasta que llegue a 0, momento en que completa la fase.
  void startTimer() {
    if (_state.isRunning) return;
    
    _state = _state.copyWith(isRunning: true);
    notifyListeners();
    NotificationService.playTimerStartSound();

    // Crea un timer que se ejecuta cada segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.remainingSeconds > 0) {
        // Decrementa el tiempo restante
        _state = _state.copyWith(remainingSeconds: _state.remainingSeconds - 1);
        notifyListeners();
      } else {
        // Si llega a 0, completa la fase actual
        _completePhase();
      }
    });
  }

  /// Pausa el timer si está corriendo.
  /// Cancela el timer periódico y actualiza el estado.
  void pauseTimer() {
    if (!_state.isRunning) return;
    
    _timer?.cancel();
    _state = _state.copyWith(isRunning: false);
    notifyListeners();
    NotificationService.playTimerPauseSound();
  }

  /// Reinicia el timer a su configuración inicial.
  /// Restablece el tiempo, la fase a focus, y el contador de pomodoros completados a 0.
  void resetTimer() {
    _timer?.cancel();
    _state = PomodoroState(
      remainingSeconds: _state.config.focusMinutes * 60,
      phase: PomodoroPhase.focus,
      isRunning: false,
      completedPomodoros: 0,
      config: _state.config,
    );
    notifyListeners();
  }

  /// Actualiza la configuración del timer.
  /// Cancela el timer actual y reinicia con la nueva configuración.
  void updateConfig(TimerConfig config) {
    _timer?.cancel();
    _state = PomodoroState(
      remainingSeconds: config.focusMinutes * 60,
      phase: PomodoroPhase.focus,
      isRunning: false,
      completedPomodoros: 0,
      config: config,
    );
    notifyListeners();
  }

  /// Agrega una configuración de timer personalizada.
  /// Si el nombre ya existe, genera un nombre único agregando un número.
  /// Retorna el TimerConfig guardado (puede tener nombre modificado si había duplicados).
  Future<TimerConfig?> addCustomConfig(TimerConfig config) async {
    // Genera un nombre único si el nombre ya está en uso
    String uniqueName = config.name;
    int counter = 1;
    while (_customConfigs.any((c) => c.name == uniqueName)) {
      uniqueName = '${config.name} $counter';
      counter++;
    }
    
    // Crea un nuevo config con nombre único si fue necesario
    final uniqueConfig = uniqueName != config.name
        ? TimerConfig(
            focusMinutes: config.focusMinutes,
            breakMinutes: config.breakMinutes,
            name: uniqueName,
          )
        : config;
    
    // Verifica si existe una configuración idéntica (mismo nombre, focus y break)
    if (!_customConfigs.contains(uniqueConfig)) {
      _customConfigs.add(uniqueConfig);
      notifyListeners();
      await _saveCustomConfigs();
      
      if (kDebugMode) {
        print('Custom timer saved: ${uniqueConfig.name} (${uniqueConfig.focusMinutes}/${uniqueConfig.breakMinutes})');
        print('Total custom timers: ${_customConfigs.length}');
      }
      
      return uniqueConfig;
    } else {
      if (kDebugMode) {
        print('Timer config already exists, skipping: ${uniqueConfig.name}');
      }
      // Si ya existe, retorna la configuración existente
      return _customConfigs.firstWhere((c) => c == uniqueConfig);
    }
  }

  /// Elimina una configuración de timer personalizada.
  /// Actualiza la lista y guarda los cambios en persistencia.
  Future<void> deleteCustomConfig(TimerConfig config) async {
    _customConfigs.remove(config);
    notifyListeners();
    await _saveCustomConfigs();
  }

  /// Carga las configuraciones personalizadas desde SharedPreferences.
  /// Convierte cada JSON string a un objeto TimerConfig.
  Future<void> _loadCustomConfigs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configsJson = prefs.getStringList(_customConfigsKey) ?? [];
      // Convierte cada JSON string a un objeto TimerConfig
      _customConfigs = configsJson
          .map((json) => TimerConfig.fromJson(jsonDecode(json)))
          .toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading custom configs: $e');
      }
    }
  }

  /// Guarda las configuraciones personalizadas en SharedPreferences.
  /// Convierte cada TimerConfig a JSON y las almacena como una lista de strings.
  Future<void> _saveCustomConfigs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Convierte cada config a JSON string
      final configsJson = _customConfigs
          .map((config) => jsonEncode(config.toJson()))
          .toList();
      await prefs.setStringList(_customConfigsKey, configsJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving custom configs: $e');
      }
    }
  }

  /// Completa la fase actual del Pomodoro.
  /// Si estaba en focus, incrementa el contador y pasa a break (corto o largo según corresponda).
  /// Si estaba en break, regresa a focus.
  /// Cada 4 pomodoros completados, se otorga un descanso largo (doble duración).
  void _completePhase() {
    _timer?.cancel();
    
    switch (_state.phase) {
      case PomodoroPhase.focus:
        // Incrementa el contador de pomodoros completados
        final nextCompletedCount = _state.completedPomodoros + 1;
        // Cada 4 pomodoros, otorga un descanso largo (el doble de tiempo)
        final isLongBreak = nextCompletedCount % 4 == 0;
        _state = _state.copyWith(
          completedPomodoros: nextCompletedCount,
          phase: isLongBreak 
              ? PomodoroPhase.longBreak 
              : PomodoroPhase.shortBreak,
          // Descanso largo es el doble de tiempo que el break normal
          remainingSeconds: isLongBreak
              ? _state.config.breakMinutes * 60 * 2
              : _state.config.breakMinutes * 60,
          isRunning: false,
        );
        NotificationService.playFocusCompleteSound();
        break;
      case PomodoroPhase.shortBreak:
      case PomodoroPhase.longBreak:
        // Al terminar el descanso, regresa a fase de focus
        _state = _state.copyWith(
          phase: PomodoroPhase.focus,
          remainingSeconds: _state.config.focusMinutes * 60,
          isRunning: false,
        );
        NotificationService.playBreakCompleteSound();
        break;
    }
    
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
