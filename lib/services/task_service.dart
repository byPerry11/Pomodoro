import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

/// Servicio para gestionar las tareas del usuario.
/// Utiliza SharedPreferences para persistencia de datos y ChangeNotifier para notificar cambios.
class TaskService extends ChangeNotifier {
  // Lista privada de tareas
  List<Task> _tasks = [];
  // Clave para almacenar las tareas en SharedPreferences
  static const String _tasksKey = 'pomodoro_tasks';

  // Getters públicos para acceder a las tareas
  List<Task> get tasks => _tasks;
  // Retorna solo las tareas pendientes (no completadas)
  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();
  // Retorna solo las tareas completadas
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  TaskService() {
    // Cargar las tareas guardadas al inicializar el servicio
    _loadTasks();
  }

  /// Carga las tareas guardadas desde SharedPreferences.
  /// Si no hay tareas guardadas o hay un error, inicializa con una lista vacía.
  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getStringList(_tasksKey) ?? [];
      // Convierte cada JSON string a un objeto Task
      _tasks = tasksJson
          .map((json) => Task.fromJson(jsonDecode(json)))
          .toList();
      // Notifica a los listeners que las tareas han sido cargadas
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading tasks: $e');
      }
    }
  }

  /// Guarda las tareas actuales en SharedPreferences.
  /// Convierte cada tarea a JSON y las almacena como una lista de strings.
  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Convierte cada tarea a JSON string
      final tasksJson = _tasks
          .map((task) => jsonEncode(task.toJson()))
          .toList();
      await prefs.setStringList(_tasksKey, tasksJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving tasks: $e');
      }
    }
  }

  /// Agrega una nueva tarea a la lista.
  /// [title] es requerido, [description] es opcional.
  /// La tarea se agrega al inicio de la lista y se guarda inmediatamente.
  Future<void> addTask(String title, {String? description}) async {
    // Crea una nueva tarea con ID único basado en el timestamp
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    
    // Inserta la tarea al inicio de la lista
    _tasks.insert(0, task);
    // Notifica a los listeners del cambio
    notifyListeners();
    // Guarda las tareas en persistencia
    await _saveTasks();
  }

  /// Actualiza una tarea existente.
  /// Busca la tarea por ID y la reemplaza con la nueva versión.
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
      await _saveTasks();
    }
  }

  /// Cambia el estado de completado de una tarea.
  /// Si la tarea se marca como completada, se registra la fecha de completado.
  /// Si se desmarca, se elimina la fecha de completado.
  Future<void> toggleTaskCompletion(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(
        isCompleted: !task.isCompleted,
        // Si se marca como completada, registra la fecha actual; si no, null
        completedAt: !task.isCompleted ? DateTime.now() : null,
      );
      notifyListeners();
      await _saveTasks();
    }
  }

  /// Elimina una tarea de la lista por su ID.
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
    await _saveTasks();
  }

  /// Elimina todas las tareas completadas de la lista.
  Future<void> clearCompletedTasks() async {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
    await _saveTasks();
  }
}
