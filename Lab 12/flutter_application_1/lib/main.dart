import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeviceInfoPage(),
    );
  }
}

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  static const platform = MethodChannel('device/info'); 
  String batteryLevel = "Unknown";

  Future<void> getBatteryLevel() async {
    try {
      final result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        batteryLevel = "$result%";
      });
    } on PlatformException catch (e) {
      batteryLevel = "Failed: ${e.message}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Platform Channels Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Battery Level: $batteryLevel"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text("Get Battery Level"),
            )
          ],
        ),
      ),
    );
  }
}
