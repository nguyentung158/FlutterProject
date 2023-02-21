import 'package:flutter/material.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/screens/edit_products_screen.dart';
import 'package:great_places_app/widgets/app_drawer.dart';
import 'package:great_places_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const route = '/userProductsScreen';

  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.route);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return UserProdcutItem(
              id: productsData.items[index].id,
              imageUrl: productsData.items[index].imageUrl,
              title: productsData.items[index].title,
            );
          },
          itemCount: productsData.items.length),
    );
  }
}
