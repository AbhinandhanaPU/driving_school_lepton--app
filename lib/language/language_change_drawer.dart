import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/helper/shared_pref_helper.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';

class LanguageChangeDrawerPage extends StatelessWidget {
  LanguageChangeDrawerPage({super.key});

  final List<Map<String, dynamic>> locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    // {'name': 'ಕನ್ನಡ', 'locale': const Locale('kn', 'IN')},
    // {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'മലയാളം', 'locale': const Locale('ml', 'IN')},
  ];

  Future<void> updateLanguage(Locale locale) async {
    await Get.updateLocale(locale);
    SharedPreferencesHelper.setString("langCode", locale.languageCode);
    SharedPreferencesHelper.setString("countryCode", locale.countryCode ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Language".tr),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        // backgroundColor: adminePrimayColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        height: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ElevatedButton(
              child: Text(locale[index]['name']),
              onPressed: () async {
                log("print");
                await updateLanguage(locale[index]['locale'])
                    .then((value) => Get.back());
              },
            );
          },
          itemCount: locale.length,
        ),
      ),
    );
  }
}
