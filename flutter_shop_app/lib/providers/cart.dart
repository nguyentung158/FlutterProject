import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.id, this.title, this.quantity, this.price);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) {
          return CartItem(
              value.id, value.title, value.quantity + 1, value.price);
        },
      );
      notifyListeners();
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(DateTime.now().toString(), title, 1, price),
      );
      notifyListeners();
    }
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeAll() {
    _items = {};
    notifyListeners();
  }
}
