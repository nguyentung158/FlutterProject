import 'package:flutter/material.dart';
import 'package:great_places_app/providers/cart.dart' show Cart;
import 'package:great_places_app/providers/orders.dart';
import 'package:great_places_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // OrderButton(cart: cart),
                  TextButton(
                      onPressed: () async {
                        await Provider.of<Orders>(context, listen: false)
                            .addOrder(
                                cart.items.values.toList(), cart.totalAmount);
                        cart.removeAll();
                      },
                      child: const Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                  productId: cart.items.keys.toList()[index],
                  id: cart.items.values.toList()[index].id,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                  title: cart.items.values.toList()[index].title),
              itemCount: cart.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
