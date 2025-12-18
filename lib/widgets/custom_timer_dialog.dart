import 'package:flutter/material.dart';
import '../models/timer_config.dart';

/// Diálogo minimalista para crear una configuración de timer personalizada.
/// Permite al usuario definir nombre, tiempo de focus y tiempo de descanso.
class CustomTimerDialog extends StatefulWidget {
  const CustomTimerDialog({super.key});

  @override
  State<CustomTimerDialog> createState() => _CustomTimerDialogState();
}

class _CustomTimerDialogState extends State<CustomTimerDialog> {
  final TextEditingController _nameController = TextEditingController();
  int _focusMinutes = 25;
  int _breakMinutes = 5;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Nuevo Timer',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Personaliza tus intervalos de enfoque',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 32),
              
              // Timer Name
              _buildLabel('Nombre del timer'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Ej: Trabajo profundo',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const SizedBox(height: 24),
              
              // Focus and Break Time in Row
              Row(
                children: [
                  // Focus Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Enfoque (min)'),
                        const SizedBox(height: 8),
                        _buildNumberInput(
                          value: _focusMinutes,
                          onDecrement: _focusMinutes > 1 
                              ? () => setState(() => _focusMinutes--) 
                              : null,
                          onIncrement: _focusMinutes < 120 
                              ? () => setState(() => _focusMinutes++) 
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Break Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Descanso (min)'),
                        const SizedBox(height: 8),
                        _buildNumberInput(
                          value: _breakMinutes,
                          onDecrement: _breakMinutes > 1 
                              ? () => setState(() => _breakMinutes--) 
                              : null,
                          onIncrement: _breakMinutes < 60 
                              ? () => setState(() => _breakMinutes++) 
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      final config = TimerConfig(
                        focusMinutes: _focusMinutes,
                        breakMinutes: _breakMinutes,
                        name: _nameController.text.isEmpty 
                            ? 'Timer Personalizado' 
                            : _nameController.text,
                      );
                      Navigator.of(context).pop(config);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Crear',
                      style: TextStyle(
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

  Widget _buildNumberInput({
    required int value,
    required VoidCallback? onDecrement,
    required VoidCallback? onIncrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Decrement button
          InkWell(
            onTap: onDecrement,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.remove,
                size: 18,
                color: onDecrement != null 
                    ? Theme.of(context).colorScheme.onSurface 
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
          ),
          // Value display
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
              ),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Increment button
          InkWell(
            onTap: onIncrement,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.add,
                size: 18,
                color: onIncrement != null 
                    ? Theme.of(context).colorScheme.onSurface 
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
