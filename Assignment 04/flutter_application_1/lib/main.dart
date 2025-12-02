import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';
import 'repositories/activity_repository.dart';
import 'providers/activity_provider.dart';
import 'screens/home_screen.dart';

void main() {
  // set your API base URL here (for dev use http://10.0.2.2:3000 or localhost for emulator)
  const baseUrl = 'http://10.0.2.2:3000';
  runApp(MyApp(baseUrl: baseUrl));
}

class MyApp extends StatelessWidget {
  final String baseUrl;
  const MyApp({super.key, required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    final api = ApiService(baseUrl: baseUrl);
    final local = LocalStorageService();
    final repo = ActivityRepository(api: api, local: local);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityProvider(repo: repo)),
      ],
      child: MaterialApp(
        title: 'SmartTracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
