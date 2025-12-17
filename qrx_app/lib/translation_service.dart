import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class TranslationService {
  static final String _apiKey = Platform.environment['TRANSLATION_API_KEY']!;
  static final String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static final Map<String, String> _cache = {};

  Future<String> translate(String text, String targetLanguage) async {
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
        final translatedText = data['candidates'][0]['content']['parts'][0]
                ['text']
            .toString()
            .trim();

        _cache[cacheKey] = translatedText;
        return translatedText;
      } else {
        return text;
      }
    } catch (e) {
      return text;
    }
  }
}
