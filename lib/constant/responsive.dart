import 'package:flutter/material.dart';

class ResponsiveApp {
  static late double width;
  static late double height;

  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
  }
}
