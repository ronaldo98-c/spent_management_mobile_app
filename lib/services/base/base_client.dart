import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spent_mananagement_mobile/constants/network_constants.dart';

class BaseClient {
  final String baseUrl = NetworkConstants.baseURL;

  BaseClient();

  // Méthode GET générique
  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final response = await http.get(uri);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erreur GET: $e');
    }
  }

  // Méthode POST générique
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erreur POST: $e');
    }
  }

  // Méthode PUT générique
  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erreur PUT: $e');
    }
  }

  // Méthode DELETE générique
  Future<dynamic> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(uri);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erreur DELETE: $e');
    }
  }

  // Gestion des réponses HTTP
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur HTTP (${response.statusCode}): ${response.body}');
    }
  }
}
