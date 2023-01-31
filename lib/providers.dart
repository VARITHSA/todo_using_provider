import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Item {
  String item;
  bool completed;
  Item({
    required this.item,
    this.completed = false,
  });
  void toggle() {
    completed = !completed;
  }
}

class ItemData with ChangeNotifier {
  final List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  get size => _items.length;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void toggleItem(Item item) {
    item.toggle();
    notifyListeners();
  }
}
