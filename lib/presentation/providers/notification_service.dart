import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class NotificationService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playFocusCompleteSound(bool enabled) async {
    if (!enabled) return;
    try {
      await _audioPlayer
          .play(AssetSource('notification_sounds/Bell  Sound.mp3'));
      await HapticFeedback.heavyImpact();
    } catch (e) {
      await SystemSound.play(SystemSoundType.alert);
    }
  }

  static Future<void> playBreakCompleteSound(bool enabled) async {
    if (!enabled) return;
    try {
      await _audioPlayer
          .play(AssetSource('notification_sounds/Bell  Sound.mp3'));
      await HapticFeedback.mediumImpact();
    } catch (e) {
      await SystemSound.play(SystemSoundType.click);
    }
  }

  static Future<void> playTimerStartSound(bool enabled) async {
    if (!enabled) return;
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Silent fallback
    }
  }

  static Future<void> playTimerPauseSound(bool enabled) async {
    if (!enabled) return;
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
