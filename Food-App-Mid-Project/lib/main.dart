import 'package:flutter/material.dart';
import 'package:food_app/screens/homepage/homeScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: homeScreen(),
    );
  }
}
