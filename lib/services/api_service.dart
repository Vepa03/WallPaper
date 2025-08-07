import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String apiKey = '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'; // BURAYA API KEY'İNİ KOY

  static Future<String> getAIResponse(String userMessage) async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "model": "mistralai/mistral-7b-instruct", // Ücretsiz, hızlı model
      "messages": [
        {"role": "user", "content": userMessage}
      ]
    });

    final response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['choices'][0]['message']['content'];
    } else {
      return "Hata: ${response.statusCode}\n${response.body}";
    }
  }
}
