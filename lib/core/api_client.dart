import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'http://YOUR_API_URL';

  static Future<dynamic> get(String path) async {
    final res = await http.get(Uri.parse('$baseUrl$path'));
    return jsonDecode(res.body);
  }

  static Future<void> delete(String path) async {
    await http.delete(Uri.parse('$baseUrl$path'));
  }

  static Future<dynamic> post(String path, Map body) async {
    final res = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(res.body);
  }
}
