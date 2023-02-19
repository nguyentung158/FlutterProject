import 'package:flutter/material.dart';
import 'package:great_places_app/providers/cart.dart';
import 'package:great_places_app/providers/product.dart';
import 'package:great_places_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.route, arguments: product.id);
      },
      child: ClipRRect(
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, value, child) {
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: product.isFavourite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    product.changeFavourite();
                  },
                );
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
              },
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}