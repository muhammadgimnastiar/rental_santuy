import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

initializeNotification() async {
  final fcm = FirebaseMessaging.instance;

  try {
    if (Platform.isAndroid) {
      await fcm.requestPermission(
        sound: true,
        alert: true,
        badge: true,
      );

      await fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onOpened);
      debugPrint("Token: ${(fcm.getToken()).toString()}");

      final messange = fcm.getInitialMessage();

      messange.then((value) {
        if (value != null) {
          debugPrint(value.notification?.title);
          debugPrint(value.notification?.body);
        }
      });
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  final messange = fcm.getInitialMessage();

  messange.then((value) {
    if (value != null) {
      debugPrint(value.notification?.title);
      debugPrint(value.notification?.body);
    }
  });
}

void _onMessage(RemoteMessage message) {
  debugPrint("Kamu Menerima Pesan ${message.notification!.title}");
  debugPrint(" ${message.notification?.body}");
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  debugPrint(
      "Kamu Menerima Pesan dari backround:  ${message.notification!.title}");
  debugPrint(" ${message.notification?.body}");
}

void _onOpened(RemoteMessage message) async {
  final data = message.data;
  debugPrint("Kamu Membuka notification");
}
