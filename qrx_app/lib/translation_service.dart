import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  // 1. Get your API Key from https://aistudio.google.com/
  static const String _apiKey = 'AIzaSyDjvIWAFPwJ5Pqho_LbVfZNbKCb5QJqZRU';
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static final Map<String, String> _cache = {};

  Future<String> translate(String text, String targetLanguage) async {
    // Mapping internal keys to full names for the LLM
    String langName = targetLanguage == 'ceb'
        ? 'Cebuano'
        : (targetLanguage == 'fil' ? 'Filipino' : 'English');

    final cacheKey = '$text-$targetLanguage';
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Translate the following medical app UI text to $langName. Provide only the translated text without any explanations: $text"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Navigate the Gemini JSON response structure
        final translatedText = data['candidates'][0]['content']['parts'][0]
                ['text']
            .toString()
            .trim();

        _cache[cacheKey] = translatedText;
        return translatedText;
      } else {
        return text; // Fallback to original text if API fails
      }
    } catch (e) {
      return text; // Fallback on error
    }
  }
}
