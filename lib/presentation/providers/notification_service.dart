import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Darwin (iOS/macOS) settings - request permissions immediately
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(initializationSettings);

    // Platform-specific additional permission request for Android 13+
    final platform = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (platform != null) {
      await platform.requestNotificationsPermission();
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pomodoro_timer_channel', // id
      'Pomodoro Timer', // title
      channelDescription: 'Notifications for Pomodoro timer completion',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }

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
