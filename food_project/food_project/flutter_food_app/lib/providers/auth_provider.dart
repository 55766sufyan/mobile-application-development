import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? token;
  Map<String,dynamic>? user;

  Future<bool> signup(String name, String email, String password, String phone) async {
    final res = await http.post(Uri.parse('$API_BASE/auth/signup'), headers: {'Content-Type':'application/json'},
      body: jsonEncode({'name':name,'email':email,'password':password,'phone':phone}));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      token = data['token'];
      user = data['user'];
      await storage.write(key:'jwt', value: token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final res = await http.post(Uri.parse('$API_BASE/auth/login'), headers: {'Content-Type':'application/json'},
      body: jsonEncode({'email':email,'password':password}));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      token = data['token'];
      user = data['user'];
      await storage.write(key:'jwt', value: token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    token = null;
    user = null;
    await storage.delete(key:'jwt');
    notifyListeners();
  }

  bool get isAuthenticated => token != null;
}
