import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/cart_screen.dart';
import 'screens/home/order_tracking_screen.dart';
import 'screens/home/order_history_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/admin/admin_login.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/manage_menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Food',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Color(0xFFFF6B35),
          scaffoldBackgroundColor: Color(0xFFF8F9FA),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFFF6B35),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF6B35),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFFFF6B35),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => HomeScreen(),
          '/login': (_) => LoginScreen(),
          '/signup': (_) => SignupScreen(),
          '/cart': (_) => CartScreen(),
          '/tracking': (_) => OrderTrackingScreen(),
          '/orders-history': (_) => OrdersHistoryScreen(),
          '/admin-login': (_) => AdminLoginScreen(),
          '/admin-dashboard': (_) => AdminDashboard(),
          '/admin-manage-menu': (_) => ManageMenuScreen(),
        },
      ),
    );
  }
}