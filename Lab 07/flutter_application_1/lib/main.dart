import 'package:flutter/material.dart';

void main() {
  runApp(BasicWidgetsApp());
}

class BasicWidgetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Widgets Example',
      home: BasicHomePage(),
    );
  }
}

class BasicHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Widgets Example'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Simple Text Widget ---
              Text(
                'Welcome to My Profile!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              SizedBox(height: 20),

              // --- RichText Widget ---
              RichText(
                text: TextSpan(
                  text: 'This app shows how to use ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'basic Flutter widgets ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: 'in one simple example.'),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // --- Row Widget ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 40, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Name: Ali Khan',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              SizedBox(height: 15),

              // --- Another Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 40, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Text(
                    'Email: ali@example.com',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // --- Buttons Example ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Edit Profile Pressed')),
                      );
                    },
                    child: Text('Edit'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout Pressed')),
                      );
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // --- Container Example ---
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'This is a Container widget — it can hold other widgets and be styled with color, padding, and border radius.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
