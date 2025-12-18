import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import '../widgets/add_task_dialog.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Objetivos',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Courier',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Consumer<TaskService>(
                    builder: (context, taskService, child) {
                      return IconButton(
                        onPressed: taskService.completedTasks.isNotEmpty
                            ? () => _showClearCompletedDialog(context, taskService)
                            : null,
                        icon: const Icon(Icons.clear_all, size: 24),
                        tooltip: 'Limpiar completadas',
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    },
                  ),
                ],
              ),
            ),
            // Tasks list
            Expanded(
              child: Consumer<TaskService>(
                builder: (context, taskService, child) {
                  return taskService.tasks.isEmpty
                      ? _buildEmptyState(context)
                      : _buildTasksList(context, taskService);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay tareas',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontFamily: 'Courier',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toca el + para agregar una tarea',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              fontSize: 14,
              fontFamily: 'Courier',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(BuildContext context, TaskService taskService) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: taskService.tasks.length,
      itemBuilder: (context, index) {
        final task = taskService.tasks[index];
        return _buildTaskItem(context, task, taskService);
      },
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task, TaskService taskService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => taskService.toggleTaskCompletion(task.id),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Courier',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.description != null
            ? Text(
                task.description!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Courier',
                  fontSize: 12,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              )
            : null,
        trailing: IconButton(
          onPressed: () => _showDeleteTaskDialog(context, task, taskService),
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.secondary,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );
    
    if (result != null) {
      final taskService = context.read<TaskService>();
      await taskService.addTask(
        result['title']!,
        description: result['description'],
      );
    }
  }

  void _showDeleteTaskDialog(BuildContext context, Task task, TaskService taskService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        title: Text(
          'ELIMINAR TAREA',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '¿Estás seguro de que quieres eliminar "${task.title}"?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Courier',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCELAR',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              taskService.deleteTask(task.id);
              Navigator.of(context).pop();
            },
            child: Text(
              'ELIMINAR',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCompletedDialog(BuildContext context, TaskService taskService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        title: Text(
          'LIMPIAR COMPLETADAS',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '¿Eliminar todas las tareas completadas?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Courier',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCELAR',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              taskService.clearCompletedTasks();
              Navigator.of(context).pop();
            },
            child: Text(
              'LIMPIAR',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
