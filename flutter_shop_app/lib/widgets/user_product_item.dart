import 'package:flutter/material.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';

class UserProdcutItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProdcutItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductsScreen.route, arguments: id);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    try {
                      Provider.of<Products>(context, listen: false)
                          .deleteProduct(id);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deleting failed'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
