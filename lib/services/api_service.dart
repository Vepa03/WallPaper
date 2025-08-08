import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String apiKey = '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'; 

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
