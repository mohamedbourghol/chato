import 'package:chato/Globals.dart';
import 'package:chato/feature/Conversation/conversation.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




Future<void> showNotification(
    {required String title, required String details,
      required String? screen,required String? conversationId,
      UserData? user
    }) async {

  String? selectedNotificationPayload;
  // ignore: close_sinks
  final BehaviorSubject<String?> selectNotificationSubject =
  BehaviorSubject<String?>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;

  }
  // ignore: close_sinks
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      });


  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    print("*****");
        print(screen);
        print(conversationId);
        if(screen=='privet_message')
          {

            Global.navigatorKey.currentState!.pushNamed('/conversationScreen',
            arguments: ConversationArguments(
                conversationId: conversationId!,
                userTwoImage:user!.img! ,
                user: null,
                userTwoName: user.name!, userTwoId: user.id),
            );
          }
       print("*****");

        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      });

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0, title,
    details ,
    platformChannelSpecifics,
    payload: screen

  );
}
class ReceivedNotification {
  ReceivedNotification({
     required this.id,
     required this.title,
     required this.body,
    required this.payload,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}