import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/api_service.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItemModel> items = [];

  Future<void> fetchMenu() async {
    final res = await ApiService.get('/menu');
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      items = list.map((e) => MenuItemModel.fromJson(e)).toList();
      notifyListeners();
    } else {
      // handle errors or empty
    }
  }
}
