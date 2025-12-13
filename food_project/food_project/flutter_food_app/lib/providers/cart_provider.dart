import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartProvider with ChangeNotifier {
  Map<String,int> _items = {}; // id -> qty

  void add(MenuItemModel item) {
    _items[item.id] = (_items[item.id] ?? 0) + 1;
    notifyListeners();
  }

  void remove(MenuItemModel item) {
    if (_items[item.id] != null) {
      _items[item.id] = _items[item.id]! - 1;
      if (_items[item.id]! <= 0) _items.remove(item.id);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Map<String,int> get items => _items;
}
