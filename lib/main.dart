import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/firebase_options.dart';
import 'package:new_project_app/view/splash_screen/splash_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      designSize: const Size(423.5294196844927, 945.8823706287004),
      builder: (context) {
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
          home: const SplashScreen(),
        );
      },
    );
  }
}
