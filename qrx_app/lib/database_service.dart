import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  static const String _baseUrl =
      'http://192.168.254.102:80/verify.php'; //if other device, use device ip

  Future<Map<String, dynamic>> verifyMedicine(
      String name, String manufacturer) async {
    try {
      if (name.isEmpty || manufacturer.isEmpty) {
        print("Invalid Input: name or manufacturer is empty.");
        throw Exception(
            "Invalid Input: Both name and manufacturer are required.");
      }

      final url = Uri.parse('$_baseUrl?name=$name&manufacturer=$manufacturer');

      // Print request data
      print("Sending request to $url");

      final response = await http.get(url);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("Decoded Response: $responseBody");
        return responseBody;
      } else {
        print("Error: Received non-200 status code: ${response.statusCode}");
        throw Exception('Failed to load medicine data');
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      rethrow;
    }
  }
}
