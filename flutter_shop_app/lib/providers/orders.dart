import 'package:flutter/foundation.dart';
import 'package:great_places_app/providers/cart.dart';

class OrdersItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrdersItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrdersItem> _orders = [];

  List<OrdersItem> get orders => [..._orders];

  void addOrder(List<CartItem> products, double total) {
    _orders.insert(
        0,
        OrdersItem(
            id: DateTime.now().toString(),
            amount: total,
            products: products,
            dateTime: DateTime.now()));
  }
}
