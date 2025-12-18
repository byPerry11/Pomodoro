import 'package:flutter/material.dart';
import 'package:pomodoro_app/l10n/app_localizations.dart';
import '../../domain/entities/task.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TaskUrgency _selectedUrgency = TaskUrgency.normal;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateButtonState);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _getUrgencyLabel(BuildContext context, TaskUrgency urgency) {
    final l10n = AppLocalizations.of(context)!;
    switch (urgency) {
      case TaskUrgency.urgent:
        return l10n.urgencyUrgent;
      case TaskUrgency.normal:
        return l10n.urgencyNormal;
      case TaskUrgency.canWait:
        return l10n.urgencyCanWait;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 32,
            right: 32,
            top: 32,
            bottom: 32 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                l10n.addTaskTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.addTaskSubtitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 32),

              // Task Title
              _buildLabel(l10n.addTaskHint),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                autofocus: true,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: l10n.addTaskExample,
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const SizedBox(height: 24),

              // Task Description
              _buildLabel(l10n.addTaskDescHint),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: l10n.addTaskDescPlaceholder,
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const SizedBox(height: 24),

              // Urgency Level
              _buildLabel(l10n.urgencyLabel),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<TaskUrgency>(
                    value: _selectedUrgency,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onChanged: (TaskUrgency? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedUrgency = newValue;
                        });
                      }
                    },
                    items: TaskUrgency.values.map((TaskUrgency urgency) {
                      return DropdownMenuItem<TaskUrgency>(
                        value: urgency,
                        child: Text(
                          _getUrgencyLabel(context, urgency),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      l10n.cancelButton,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _titleController.text.trim().isEmpty
                        ? null
                        : () {
                            final title = _titleController.text.trim();
                            if (title.isEmpty) return;

                            final description =
                                _descriptionController.text.trim().isEmpty
                                ? null
                                : _descriptionController.text.trim();

                            Navigator.of(context).pop(<String, dynamic>{
                              'title': title,
                              'description': description,
                              'urgency': _selectedUrgency,
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      disabledBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.createButton,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
