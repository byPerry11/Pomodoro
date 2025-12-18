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

  List<Task> get tasks => _tasks;

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
    _tasks = await _getTasks();
    notifyListeners();
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

    await _addTask(task);
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
      await _updateTask(updatedTask);
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
    await _deleteTask(taskId);
  }

  Future<void> clearCompletedTasks() async {
    final completed = _tasks.where((t) => t.isCompleted).toList();
    for (final task in completed) {
      await deleteTask(task.id);
    }
  }
}
