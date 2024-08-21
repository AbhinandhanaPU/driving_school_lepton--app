import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/responsive.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/firebase_options.dart';
import 'package:new_project_app/service/pushnotification_service/pushnotification_service.dart';
import 'package:new_project_app/view/mock_test/user/question_viewer.dart';
import 'package:new_project_app/view/splash_screen/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future _firebasebackgrounMessage(RemoteMessage message) async {
  if (message.notification != null) {
    // log("some notification recieved in background");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling  a background message ${message.messageId}');
}

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //creating shared preference
  await SharedPreferencesHelper.initPrefs();
  await PushNotification.init();
  await PushNotification.localnotiInit();
  FirebaseMessaging.onBackgroundMessage(_firebasebackgrounMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      log("Backgroundnitfication tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });
  //to handle foreground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payLoadData = jsonEncode(message.data);
    log('Got a message in foreground');
    if (message.notification != null) {
      PushNotification.showSimpleNotifivation(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payLoad: payLoadData);
    }
  });
  ///////////for handling the terminated state
  final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    log('Launched from terminated state');
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
//  await callCloudFunction();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      designSize: const Size(423.5294196844927, 945.8823706287004),
      builder: (context) {
        ResponsiveApp.serMq(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            tabBarTheme: TabBarTheme(
              unselectedLabelColor: cWhite,
              labelColor: Colors.blue[100],
              indicatorColor: Colors.green,
            ),
            appBarTheme: const AppBarTheme(foregroundColor: cWhite),
          ),
          home:SplashScreen(),
        );
      },
    );
  }
}
