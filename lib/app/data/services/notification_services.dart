// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // initializeNotification() async {
  //   // tz.initializeTimeZones();
  //   // final IOSInitializationSettings initializationSettingsIOS =
  //   //     IOSInitializationSettings(
  //   //         requestSoundPermission: false,
  //   //         requestBadgePermission: false,
  //   //         requestAlertPermission: false,
  //   //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  //   final AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings("appicon");

  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     //iOS: initializationSettingsIOS,
  //     android: initializationSettingsAndroid,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //   //    onSelectNotification: selectNotification);
  // }

  // Future selectNotification(String payload) async {
  //   if (payload != null) {
  //     print('notification payload: $payload');
  //   } else {
  //     print("Notification Done");
  //   }
  //   // Get.to(() => SecondScreen(payload));
  // }

  // Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   Get.dialog(Text("TEST Dialog"));
  //   // showDialog(
  //   //   context: context,
  //   //   builder: (BuildContext context) => CupertinoAlertDialog(
  //   //     title: Text(title),
  //   //     content: Text(body),
  //   //     actions: [
  //   //       CupertinoDialogAction(
  //   //         isDefaultAction: true,
  //   //         child: Text('Ok'),
  //   //         onPressed: () async {
  //   //           Navigator.of(context, rootNavigator: true).pop();
  //   //           await Navigator.push(
  //   //             context,
  //   //             MaterialPageRoute(
  //   //               builder: (context) => SecondScreen(payload),
  //   //             ),
  //   //           );
  //   //         },
  //   //       )
  //   //     ],
  //   //   ),
  //   // );
  // }

  // displayNotification({required String title, required String body}) async {
  //   print("doing test");
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'your channel name', 'your channel description',
  //       importance: Importance.max, priority: Priority.high);
  //   // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics =
  //       new NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'You change your theme',
  //     'You changed your theme back !',
  //     platformChannelSpecifics,
  //     payload: 'It could be anything you pass',
  //   );
  // }

  // void requestIOSPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }
}
