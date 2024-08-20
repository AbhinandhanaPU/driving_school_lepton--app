import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project_app/controller/mock_test/admin_side/adminside_controller.dart';

class TranslationService {
  
  final String apiKey = 'AIzaSyCJ9d-ofeEZQ-RzEQbrux-U-8ve_uh4fWE';  
  final String endpoint = 'https://translation.googleapis.com/language/translate/v2';

  Future<String> translateText(String text, ) async {
    final response = await http.post(
      Uri.parse('$endpoint?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': text,
        'target': Get.find<QuizTestAdminSideController>().selectedLanguage.value,
        'format': 'text',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text: ${response.body}');
    }
  }
}
