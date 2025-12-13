import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);
  
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  List orders = [];
  final storage = FlutterSecureStorage();
  bool loading = true;
  late TabController _tabController;
  
  Map<String, List> ordersByStatus = {
    'Pending': [],
    'Preparing': [],
    'Ready': [],
    'Completed': [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchOrders() async {
    setState(() => loading = true);
    final token = await storage.read(key: 'jwt');
    final res = await http.get(
      Uri.parse('$API_BASE/orders'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (res.statusCode == 200) {
      final allOrders = jsonDecode(res.body) as List;
      setState(() {
        orders = allOrders;
        ordersByStatus = {
          'Pending': allOrders.where((o) => o['status'] == 'Pending').toList(),
          'Preparing': allOrders.where((o) => o['status'] == 'Preparing').toList(),
          'Ready': allOrders.where((o) => o['status'] == 'Ready').toList(),
          'Completed': allOrders.where((o) => o['status'] == 'Completed').toList(),
        };
        loading = false;
      });
    }
  }

  Future<void> changeStatus(String orderId, String status) async {
    final token = await storage.read(key: 'jwt');
    final res = await http.put(
      Uri.parse('$API_BASE/orders/$orderId/status'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'status': status}),
    );
    
    if (res.statusCode == 200) {
      fetchOrders();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated'), backgroundColor: Colors.green),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Preparing':
        return Colors.blue;
      case 'Ready':
        return Colors.green;
      case 'Completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildOrderCard(Map order) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(order['status']),
          child: Icon(Icons.receipt, color: Colors.white),
        ),
        title: Text(
          order['orderId'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Customer: ${order['user']['name']}'),
            Text('Total: Rs ${order['totalAmount']}'),
            Text(
              DateTime.parse(order['createdAt']).toString().split('.')[0],
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        children: [
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                ...((order['items'] as List).map((item) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item['quantity']}x ${item['name']}'),
                          Text('Rs ${item['price'] * item['quantity']}'),
                        ],
                      ),
                    ))),
                SizedBox(height: 16),
                Text(
                  'Contact: ${order['user']['email']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                if (order['user']['phone'] != null)
                  Text(
                    'Phone: ${order['user']['phone']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                SizedBox(height: 16),
                Text('Update Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Pending', 'Preparing', 'Ready', 'Completed'].map((status) {
                    final isSelected = order['status'] == status;
                    return ChoiceChip(
                      label: Text(status),
                      selected: isSelected,
                      selectedColor: _getStatusColor(status),
                      onSelected: (selected) {
                        if (selected && !isSelected) {
                          changeStatus(order['_id'], status);
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String status) {
    final statusOrders = ordersByStatus[status] ?? [];
    
    if (statusOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No $status orders', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchOrders,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 8, bottom: 16),
        itemCount: statusOrders.length,
        itemBuilder: (ctx, i) => _buildOrderCard(statusOrders[i]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Admin Dashboard')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            tooltip: 'Manage Menu',
            onPressed: () => Navigator.pushNamed(context, '/admin-manage-menu'),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchOrders,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              child: Row(
                children: [
                  Text('Pending'),
                  SizedBox(width: 4),
                  if (ordersByStatus['Pending']!.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${ordersByStatus['Pending']!.length}',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Text('Preparing'),
                  SizedBox(width: 4),
                  if (ordersByStatus['Preparing']!.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${ordersByStatus['Preparing']!.length}',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Text('Ready'),
                  SizedBox(width: 4),
                  if (ordersByStatus['Ready']!.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${ordersByStatus['Ready']!.length}',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('Pending'),
          _buildTabContent('Preparing'),
          _buildTabContent('Ready'),
          _buildTabContent('Completed'),
        ],
      ),
    );
  }
}