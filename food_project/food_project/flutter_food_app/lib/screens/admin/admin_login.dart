import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class AdminLoginScreen extends StatefulWidget {
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;
  final storage = FlutterSecureStorage();

  login() async {
    setState(() => loading = true);
    final res = await http.post(Uri.parse('$API_BASE/auth/login'),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({'email':emailC.text,'password':passC.text}));
    setState(() => loading = false);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data['user']['isAdmin'] == true) {
        await storage.write(key: 'jwt', value: data['token']);
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not admin')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: emailC, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passC, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(onPressed: loading ? null : login, child: loading ? CircularProgressIndicator() : Text('Login'))
          ]),
        ),
      ),
    );
  }
}
