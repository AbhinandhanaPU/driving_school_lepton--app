// ignore_for_file: camel_case_types

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/fonts/fonts.dart';

// ignore: must_be_immutable
class loginButtonWidget extends StatelessWidget {
  String text;
  double height;
  double width;

  loginButtonWidget({
    required this.height,
    required this.width,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 230.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: themeColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyleFonts.subHeadTextStyle,
        ),
      ),
    );
  }
}
