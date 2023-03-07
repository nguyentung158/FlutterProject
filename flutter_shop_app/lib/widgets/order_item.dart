import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrdersItem ordersItem;

  const OrderItem({super.key, required this.ordersItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.ordersItem.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy hh:mm a')
                  .format(widget.ordersItem.dateTime),
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: IconButton(
              icon: _isExpanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded
                ? min(widget.ordersItem.products.length * 20.0 + 70, 180)
                : 0,
            child: ListView(
              children: widget.ordersItem.products.map((product) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        '${product.quantity} x \$${product.price}',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
