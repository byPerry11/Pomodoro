import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../providers/task_service.dart';
import '../../domain/entities/task.dart';
import '../widgets/add_task_dialog.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access localizations
    final l10n = AppLocalizations.of(context)!;

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
                  Expanded(
                    child: Text(
                      l10n.tasksTitle,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Consumer<TaskService>(
                    builder: (context, taskService, child) {
                      return IconButton(
                        onPressed: taskService.completedTasks.isNotEmpty
                            ? () => _showClearCompletedDialog(
                                context,
                                taskService,
                              )
                            : null,
                        icon: const Icon(Icons.clear_all, size: 24),
                        tooltip: l10n.clearCompletedTitle,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110.0),
        child: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noTasks,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.tapPlusToAddTask,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.7),
              fontSize: 14,
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

  Widget _buildTaskItem(
    BuildContext context,
    Task task,
    TaskService taskService,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Color indicator bar at the top
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: _getUrgencyColor(task.urgency),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) => taskService.toggleTaskCompletion(task),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: task.description != null
                ? Text(
                    task.description!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  )
                : null,
            trailing: IconButton(
              onPressed: () =>
                  _showDeleteTaskDialog(context, task, taskService),
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.secondary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(TaskUrgency urgency) {
    switch (urgency) {
      case TaskUrgency.urgent:
        return const Color(0xFFE7180B); // Soft red
      case TaskUrgency.normal:
        return const Color.fromARGB(255, 21, 218, 37); // Soft amber
      case TaskUrgency.canWait:
        return const Color.fromARGB(255, 59, 84, 226); // Soft green
    }
  }

  void _showAddTaskDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );

    if (result != null && context.mounted) {
      final taskService = context.read<TaskService>();
      await taskService.addTask(
        result['title']!,
        description: result['description'],
        urgency: result['urgency'] ?? TaskUrgency.normal,
      );
    }
  }

  void _showDeleteTaskDialog(
    BuildContext context,
    Task task,
    TaskService taskService,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        title: Text(
          l10n.deleteTaskTitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Text(
          l10n.deleteTaskConfirm(task.title),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
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
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              taskService.deleteTask(task.id);
              Navigator.of(context).pop();
            },
            child: Text(
              l10n.deleteButton,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCompletedDialog(
    BuildContext context,
    TaskService taskService,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        title: Text(
          l10n.clearCompletedTitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Text(
          l10n.clearCompletedConfirm,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
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
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await taskService.clearCompletedTasks();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              l10n.clearButton,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
