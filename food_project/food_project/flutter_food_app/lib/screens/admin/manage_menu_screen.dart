import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class ManageMenuScreen extends StatefulWidget {
  @override
  State<ManageMenuScreen> createState() => _ManageMenuScreenState();
}

class _ManageMenuScreenState extends State<ManageMenuScreen> {
  List menu = [];
  final storage = FlutterSecureStorage();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    setState(() => loading = true);
    final res = await http.get(Uri.parse('$API_BASE/menu'));
    if (res.statusCode == 200) {
      setState(() {
        menu = jsonDecode(res.body);
        loading = false;
      });
    }
  }

  Future<String?> pickImage() async {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();
    await input.onChange.first;
    if (input.files!.isEmpty) return null;
    final file = input.files!.first;
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    await reader.onLoad.first;
    return reader.result as String?;
  }

  Future<void> addMenuItem() async {
    final nameC = TextEditingController();
    final priceC = TextEditingController();
    final descC = TextEditingController();
    bool available = true;
    String? base64;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Add Menu Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (base64 != null)
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: MemoryImage(
                          base64Decode(base64!.split(',')[1]),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ElevatedButton.icon(
                  icon: Icon(Icons.image),
                  label: Text(base64 == null ? 'Pick Image' : 'Change Image'),
                  onPressed: () async {
                    final img = await pickImage();
                    if (img != null) {
                      setDialogState(() => base64 = img);
                    }
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: priceC,
                  decoration: InputDecoration(
                    labelText: 'Price (Rs)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: descC,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text('Available'),
                    Switch(
                      value: available,
                      onChanged: (v) => setDialogState(() => available = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameC.text.isEmpty || priceC.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Name and price required')),
                  );
                  return;
                }
                final token = await storage.read(key: 'jwt');
                await http.post(
                  Uri.parse('$API_BASE/menu'),
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'application/json'
                  },
                  body: jsonEncode({
                    'name': nameC.text,
                    'price': double.tryParse(priceC.text) ?? 0,
                    'description': descC.text,
                    'available': available,
                    'imageBase64': base64,
                  }),
                );
                Navigator.pop(ctx);
                fetchMenu();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item added'), backgroundColor: Colors.green),
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteItem(String id, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Item'),
        content: Text('Delete $name from menu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final token = await storage.read(key: 'jwt');
      await http.delete(
        Uri.parse('$API_BASE/menu/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      fetchMenu();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Menu', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : menu.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No menu items yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text('Add items to get started', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchMenu,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8, bottom: 80),
                    itemCount: menu.length,
                    itemBuilder: (ctx, i) {
                      final m = menu[i];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.fastfood, color: Colors.grey),
                          ),
                          title: Text(
                            m['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rs ${m['price']}'),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: m['available'] ? Colors.green[100] : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  m['available'] ? 'Available' : 'Not available',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: m['available'] ? Colors.green[800] : Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteItem(m['_id'], m['name']),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add Item'),
        onPressed: addMenuItem,
      ),
    );
  }
}