// ignore_for_file: must_be_immutable, unnecessary_question_mark

import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';

class LoginTextFormfield extends StatelessWidget {
  LoginTextFormfield({
    super.key,
    this.textEditingController,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.icon,
    this.obscureText,
  });
  TextEditingController? textEditingController;
  String labelText;
  String hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  dynamic? obscureText;
  String? Function(String? fieldContent)? validator;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      width: 360.w,
      child: TextFormField(
        autofocus: false,
        validator: validator,
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}
