import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'falafel_repository.dart';

class HttpFalafelService implements FalafelRepository {
  final String baseUrl = AppConfig.backendBaseUrl;

  @override
  Future<List<Map<String, dynamic>>> getFalafel() async {
    final response = await http.get(Uri.parse('$baseUrl/falafel'));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  @override
  Future<void> addFalafel(Map<String, dynamic> falafel) async {
    await http.post(
      Uri.parse('$baseUrl/falafel'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(falafel),
    );
  }

  @override
  Future<void> updateFalafel(int id, Map<String, dynamic> falafel) async {
    await http.put(
      Uri.parse('$baseUrl/falafel/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(falafel),
    );
  }

  @override
  Future<void> deleteFalafel(int id) async {
    await http.delete(Uri.parse('$baseUrl/falafel/$id'));
  }
}
