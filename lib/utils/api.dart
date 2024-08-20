import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

final apiUrl = dotenv.get('API_URL');
final secretKey = dotenv.get('API_TOKEN_SECRET_KEY');

class ApiConsumer {
  final String baseUrl;
  String? _bearerToken;

  ApiConsumer() : baseUrl = apiUrl;

  Future<void> _authenticate() async {
    final _endPoint = 'auth/token';
    final response = await http.post(
      Uri.parse('$baseUrl$_endPoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'secret_key': secretKey}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _bearerToken = data['access_token'];
      developer.log('data: $data');
      developer.log('token: $_bearerToken');
    } else {
      throw Exception('Failed to _authenticate and get bearer token');
    }
  }

  Future<http.Response> GET(String endpoint) async {
    await _authenticate();
    developer.log('$baseUrl$endpoint');
    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_bearerToken',
      },
    );
  }

  Future<http.Response> POST(String endpoint, Map<String, dynamic> data) async {
    await _authenticate();
    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_bearerToken',
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> PUT(String endpoint, Map<String, dynamic> data) async {
    await _authenticate();
    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_bearerToken',
      },
      body: jsonEncode(data),
    );
  }
}
