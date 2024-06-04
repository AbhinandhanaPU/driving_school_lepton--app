import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController fatherSpouseController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rtoNameController = TextEditingController();
  TextEditingController licenceController = TextEditingController();

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    phoneController.clear();
    dateOfBirthController.clear();
    fatherSpouseController.clear();
    placeController.clear();
    addressController.clear();
    rtoNameController.clear();
    licenceController.clear();
  }
}
