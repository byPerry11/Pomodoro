import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class NotificationService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playFocusCompleteSound() async {
    try {
      // Play a system sound for focus completion
      await SystemSound.play(SystemSoundType.alert);
    } catch (e) {
      // Fallback: just vibrate if sound fails
      await HapticFeedback.heavyImpact();
    }
  }

  static Future<void> playBreakCompleteSound() async {
    try {
      // Play a different system sound for break completion
      await SystemSound.play(SystemSoundType.click);
    } catch (e) {
      // Fallback: just vibrate if sound fails
      await HapticFeedback.mediumImpact();
    }
  }

  static Future<void> playTimerStartSound() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Silent fallback
    }
  }

  static Future<void> playTimerPauseSound() async {
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      // Silent fallback
    }
  }

  static void dispose() {
    _audioPlayer.dispose();
  }
}
