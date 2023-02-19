import 'package:flutter/material.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavourite;

  const ProductGrid({super.key, required this.showOnlyFavourite});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    var loadedProducts =
        showOnlyFavourite ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
