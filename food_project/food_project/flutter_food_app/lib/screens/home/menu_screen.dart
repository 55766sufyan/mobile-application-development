import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/menu_provider.dart';
import '../../widgets/menu_tile.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MenuProvider>(context, listen:false).fetchMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () => Navigator.pushNamed(context, '/admin-login'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => menu.fetchMenu(),
        child: menu.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No items available', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 8, bottom: 80),
                itemCount: menu.items.length,
                itemBuilder: (ctx, i) => MenuTile(item: menu.items[i]),
              ),
      ),
    );
  }
}