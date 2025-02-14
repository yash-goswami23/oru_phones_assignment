import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Foreground Notifications
    FirebaseMessaging.onMessage.listen((message) {
      print(" [Foreground] Notification: ${message.notification?.title}");
      showNotification(message.notification?.title ?? "Title",
          message.notification?.body ?? "Body");
    });

    // Background Notifications
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("[Background] Notification Clicked!");
    });

    // Terminated State Notifications
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(
            "[Terminated] Notification Opened: ${message.notification?.title}");
      }
    });
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformDetails);
  }
}
