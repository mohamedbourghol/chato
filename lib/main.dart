import 'dart:convert';
import 'dart:io';

import 'package:chato/Globals.dart';
import 'package:chato/agora/callscreen.dart';
import 'package:chato/agora/join_channel_audio.dart';
import 'package:chato/feature/User/model/user_data.dart';
import 'package:chato/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Preference.dart';
import 'core/utils/show_notification.dart';
import 'feature/Conversation/conversation.dart';
import 'feature/Pages/ProfilePage/bloc/prof_bloc.dart';
import 'feature/splash/splash_screen.dart';
import 'injection.dart' as di;
import 'core/utils/theme_manager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('_firebaseMessagingBackgroundHandler');
  print(message.data);
  print(message.data['screen']);
  print(message.data['screen_id']);

  if(message.data['screen']=='privet_message')
  {
    //UserData? user=UserData.fromJson(json.decode(message.data['user_send']));
    Global.navigatorKey.currentState!.pushNamed('/conversationScreen',
      arguments: ConversationArguments(
          conversationId: message.data['screen_id'],
          userTwoImage: null,
          userTwoName:null, userTwoId: 2,
        user: message.data['user_send']

      ),
    );
  }

  }



void main() async{
  await di.init();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Preferences.init();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage
      .listen((RemoteMessage message) {
    print("message.data");
    print(message.data);
    print(message.data);
    if(message.data['screen']=='coins')
      {
        ProfBloc profBloc=di.sl<ProfBloc>();
        profBloc.onGetProfileDetailsEvent();
        showNotification( title: message.notification!.title!,
            details:  message.notification!.body!,
            screen: message.data['screen'],
            conversationId: message.data['screen_id']
        );
      }

    if(message.data['screen']=='privet_message')
      {
        UserData? user=UserData.fromJson(json.decode(message.data['user_send']));
        showNotification( title: message.notification!.title!,
            details:  message.notification!.body!,
            screen: message.data['screen'],
            conversationId: message.data['screen_id'],
          user: user
        );
      }

  }
      );
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(message.data);
    print(message.data['screen']);
    print(message.data['screen_id']);
    if(message.data['screen']=='privet_message')
    {


      Global.navigatorKey.currentState!.pushNamed('/conversationScreen',
        arguments: ConversationArguments(
            conversationId: message.data['screen_id'],
            userTwoImage:null,
            user:  message.data['user_send'],
            userTwoName:null, userTwoId: null),
      );
    }
    //Global.navigatorKey.currentState!.pushNamed('/selectState',);
  });


  Global.darkMode=Preferences.getDarkMode()!;
  Global.lan=Preferences.getLan()!;


  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'),
          Locale('ar', 'AR')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Global.lan=='ar'?
        const Locale('ar', 'AR'):const Locale('en', 'US'),
        startLocale: Global.lan=='ar'?
        const Locale('ar', 'AR'):const Locale('en', 'US'),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>
      MaterialApp(
        title: 'Chato',
        navigatorKey: Global.navigatorKey,
        routes: routes!,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme:Global.darkMode?
              getApplicationDarkTheme()
            :getApplicationLightTheme(),
        home: const CallScreen(),
      ),
    );
  }
}


