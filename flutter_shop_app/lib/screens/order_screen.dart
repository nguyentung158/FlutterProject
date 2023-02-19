import 'package:flutter/material.dart';
import 'package:great_places_app/providers/orders.dart' show Orders;
import 'package:great_places_app/widgets/app_drawer.dart';
import 'package:great_places_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const route = '/orders';

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Previous orders',
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: const AppDrawer(),
      body: Consumer(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) =>
                OrderItem(ordersItem: orderData.orders[index]),
            itemCount: orderData.orders.length,
          );
        },
      ),
    );
  }
}
