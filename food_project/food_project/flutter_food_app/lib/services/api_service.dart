import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class ApiService {
  static Future<String?> _getToken() async {
    return await storage.read(key: 'jwt');
  }

  static Future<http.Response> get(String path) async {
    final token = await _getToken();
    return http.get(Uri.parse('$API_BASE$path'), headers: {
      'Authorization': token == null ? '' : 'Bearer $token',
      'Content-Type': 'application/json'
    });
  }

  static Future<http.Response> post(String path, Map body) async {
    final token = await _getToken();
    return http.post(Uri.parse('$API_BASE$path'), headers: {
      'Authorization': token == null ? '' : 'Bearer $token',
      'Content-Type': 'application/json'
    }, body: jsonEncode(body));
  }

  static Future<http.Response> put(String path, Map body) async {
    final token = await _getToken();
    return http.put(Uri.parse('$API_BASE$path'), headers: {
      'Authorization': token == null ? '' : 'Bearer $token',
      'Content-Type': 'application/json'
    }, body: jsonEncode(body));
  }

  static Future<http.Response> delete(String path) async {
    final token = await _getToken();
    return http.delete(Uri.parse('$API_BASE$path'), headers: {
      'Authorization': token == null ? '' : 'Bearer $token',
      'Content-Type': 'application/json'
    });
  }

  // helper to write token on login/signup
  static Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt', value: token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'jwt');
  }
}
