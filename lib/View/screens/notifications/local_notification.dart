import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification extends StatelessWidget {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    tz.initializeTimeZones(); // Initialize time zones

    // Replace 'your_timezone' with the actual timezone you want to use
    final String timeZoneName = 'America/New_York';

    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('app_icon');
    // Replace with your app icon
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _scheduleNotification();
          },
          child: Text('Pressed'),
        ),
      ),
    );
  }

  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel Name',
      channelDescription: 'Your other channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Scheduled Notification',
        'This is a scheduled notification',
        platformChannelSpecifics,
      );
    } catch (e) {
      // Handle specific platform exceptions, such as exact alarms not permitted
      print('Error scheduling notification: $e');
      // Handle the error gracefully, for example, by showing a user-friendly message.
    }
  }
}
