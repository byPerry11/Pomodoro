import 'package:flutter/material.dart';
import '../models/timer_config.dart';

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
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF00FF41), width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CUSTOM TIMER',
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 24),
            
            // Timer Name
            const Text(
              'Timer Name:',
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 14,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              style: const TextStyle(
                color: Color(0xFF00FF41),
                fontFamily: 'Courier',
              ),
              decoration: InputDecoration(
                hintText: 'My Custom Timer',
                hintStyle: TextStyle(
                  color: Color(0xFF00FF41).withOpacity(0.5),
                  fontFamily: 'Courier',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF41)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF41)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00FF41), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 24),
            
            // Focus Time
            const Text(
              'Focus Time (minutes):',
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 14,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _focusMinutes > 1 ? () => setState(() => _focusMinutes--) : null,
                  icon: const Icon(Icons.remove, color: Color(0xFF00FF41)),
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00FF41)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _focusMinutes.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _focusMinutes < 120 ? () => setState(() => _focusMinutes++) : null,
                  icon: const Icon(Icons.add, color: Color(0xFF00FF41)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Break Time
            const Text(
              'Break Time (minutes):',
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 14,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _breakMinutes > 1 ? () => setState(() => _breakMinutes--) : null,
                  icon: const Icon(Icons.remove, color: Color(0xFF00FF41)),
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00FF41)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _breakMinutes.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _breakMinutes < 60 ? () => setState(() => _breakMinutes++) : null,
                  icon: const Icon(Icons.add, color: Color(0xFF00FF41)),
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
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    final config = TimerConfig(
                      focusMinutes: _focusMinutes,
                      breakMinutes: _breakMinutes,
                      name: _nameController.text.isEmpty ? 'Custom Timer' : _nameController.text,
                    );
                    Navigator.of(context).pop(config);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF41),
                    foregroundColor: const Color(0xFF0A0A0A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'CREATE',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
