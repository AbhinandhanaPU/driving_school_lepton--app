import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString selectedLanguage = 'English'.obs; // Default language

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }
}
