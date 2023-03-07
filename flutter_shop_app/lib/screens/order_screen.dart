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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Previous orders',
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Orders>(context, listen: false).fetchAndSave();
        },
        child: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchAndSave(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error == null) {
                return Consumer<Orders>(
                  builder: (ctx, value, child) {
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          OrderItem(ordersItem: value.orders[index]),
                      itemCount: value.orders.length,
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
