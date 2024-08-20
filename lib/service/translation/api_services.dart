import 'dart:convert';

import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey = 'AIzaSyCJ9d-ofeEZQ-RzEQbrux-U-8ve_uh4fWE';  // Replace with your API key
  final String endpoint = 'https://translation.googleapis.com/language/translate/v2';

  Future<String> translateText(String text, String targetLanguage) async {
    final response = await http.post(
      Uri.parse('$endpoint?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': text,
        'target': targetLanguage,
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
