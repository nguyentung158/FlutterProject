// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/cart.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/screens/cart_screen.dart';
import 'package:great_places_app/widgets/app_drawer.dart';
import 'package:great_places_app/widgets/badge.dart';
import 'package:great_places_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavourites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('My shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValues) {
              setState(() {
                if (selectedValues == FilterOptions.All) {
                  _showOnlyFavourites = false;
                } else {
                  _showOnlyFavourites = true;
                }
              });
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: FilterOptions.Favourites,
                  child: Text('Only favourites'),
                ),
                const PopupMenuItem(
                  value: FilterOptions.All,
                  child: Text('Show all'),
                )
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: ((context, value, child) => Badge(
                value: value.itemCount.toString(),
                color: Theme.of(context).colorScheme.secondary,
                child: child!)),
            child: IconButton(
              icon: const Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(
              showOnlyFavourite: _showOnlyFavourites,
            ),
    );
  }
}
