import 'package:flutter/material.dart';
import 'package:great_places_app/providers/auth.dart';
import 'package:great_places_app/screens/order_screen.dart';
import 'package:great_places_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            alignment: Alignment.bottomRight,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Hey, User',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: Text(
              'Shop',
              style: Theme.of(context).textTheme.headline4,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(
              'Orders',
              style: Theme.of(context).textTheme.headline4,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(
              'User Products',
              style: Theme.of(context).textTheme.headline4,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.route);
            },
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.headline4,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
