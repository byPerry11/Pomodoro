import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/task_usecases.dart';

@lazySingleton
class TaskService extends ChangeNotifier {
  final GetTasks _getTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  List<Task> _tasks = [];
  String? _error;

  List<Task> get tasks => _tasks;
  String? get error => _error;

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Compatibility getters for UI
  List<Task> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((t) => t.isCompleted).toList();

  TaskService(
    this._getTasks,
    this._addTask,
    this._updateTask,
    this._deleteTask,
  ) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      _tasks = await _getTasks();
    } catch (e) {
      _error = 'Failed to load tasks: $e';
    } finally {
      notifyListeners();
    }
  }

  Future<void> addTask(String title,
      {String? description, TaskUrgency urgency = TaskUrgency.normal}) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
      urgency: urgency,
    );

    _tasks.insert(0, task);
    notifyListeners();

    try {
      await _addTask(task);
    } catch (e) {
      _tasks.remove(task); // Rollback
      _error = 'Failed to add task: $e';
      notifyListeners();
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      completedAt: !task.isCompleted ? DateTime.now() : null,
    );

    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
      try {
        await _updateTask(updatedTask);
      } catch (e) {
        _tasks[index] = task; // Rollback
        _error = 'Failed to update task: $e';
        notifyListeners();
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    final task = taskIndex != -1 ? _tasks[taskIndex] : null;

    if (task != null) {
      _tasks.removeAt(taskIndex);
      notifyListeners();
      try {
        await _deleteTask(taskId);
      } catch (e) {
        _tasks.insert(taskIndex, task); // Rollback
        _error = 'Failed to delete task: $e';
        notifyListeners();
      }
    }
  }

  Future<void> clearCompletedTasks() async {
    final completed = _tasks.where((t) => t.isCompleted).toList();
    if (completed.isEmpty) return;

    // Optimistic update
    _tasks.removeWhere((t) => t.isCompleted);
    notifyListeners();

    try {
      // Batch delete in repository would be ideal, but for now we loop
      // keeping the UI update singular.
      for (final task in completed) {
        await _deleteTask(task.id);
      }
    } catch (e) {
      // Rollback (complex in batch, but we can reload)
      _error = 'Failed to clear tasks: $e';
      await _loadTasks(); // Reload source of truth
    }
  }
}
