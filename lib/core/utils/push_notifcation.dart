// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class PushNotification {
//   static PushNotification shared = PushNotification._();

//   PushNotification._();

//   Future<String?> getToken() async => FirebaseMessaging.instance.getToken();

//   Future<void> setupPushNotification() async {
//     try {
//       final messaging = FirebaseMessaging.instance;

//       // iOS request firebase message request permission
//       await messaging.requestPermission();
//       final token = await messaging.getToken();

//       debugPrint('Fcm token: $token');

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         debugPrint('Got a message whilst in the foreground!');
//         debugPrint('Message data: ${message.data}');

//         if (message.notification != null) {
//           debugPrint('Message also contained a notification: ${message.notification}');
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp.listen((message) {
//         debugPrint('onMessageOpenedApp!');
//         debugPrint('Message data: ${message.data}');
//       });
//     } catch (e) {}
//   }
// }
