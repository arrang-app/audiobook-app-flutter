import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
    );
  }

  static Future<void> showPlaybackNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'audio_playback_channel',
      'Audio Playback',
      channelDescription: 'Playback controls for background audio',
      importance: Importance.low,
      priority: Priority.low,
      playSound: false,
      ongoing: true,
    );

    await _plugin.show(
      1,
      title,
      body,
      const NotificationDetails(android: androidDetails),
    );
  }
}
