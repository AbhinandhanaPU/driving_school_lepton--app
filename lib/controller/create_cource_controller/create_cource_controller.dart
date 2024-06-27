import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCourceController extends GetxController {

  TextEditingController courcenameController = TextEditingController();
  TextEditingController tutornameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  
  final formKey = GlobalKey<FormState>();

  void clearTextFields()  {
    courcenameController.clear();
    tutornameController.clear();
    durationController.clear();
    feeController.clear();
    descriptionController.clear();

  }
}
