import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfileEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController editvalueController = TextEditingController();
  RxBool isLoading = RxBool(false);
}
