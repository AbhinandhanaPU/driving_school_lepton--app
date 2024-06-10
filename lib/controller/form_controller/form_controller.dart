import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  void submitForm(Function function) {
    if (formKey.currentState!.validate()) {
      function;
    } else {}
  }
}
