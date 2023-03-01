import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/providers/cart.dart';
import 'package:http/http.dart' as http;

import '../models/https_exception.dart';

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
  List<OrdersItem> _orders = [];

  List<OrdersItem> get orders => [..._orders];

  Future<void> fetchAndSave() async {
    const url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    final respone = await http.get(Uri.parse(url));
    if (respone.statusCode >= 400) {
      throw HttpException('Could not load orders');
    }
    List<OrdersItem> loadedItems = [];
    final extractedData = json.decode(respone.body) as Map<String, dynamic>;
    extractedData.forEach((key, value) {
      loadedItems.add(OrdersItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ))
              .toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedItems;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    const url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    final timestamp = DateTime.now();
    final code = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': products
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }));
    if (code.statusCode >= 400) {
      throw HttpException('Could not delete product');
    }
    _orders.insert(
        0,
        OrdersItem(
            id: json.decode(code.body)['name'],
            amount: total,
            products: products,
            dateTime: DateTime.now()));
  }
}
