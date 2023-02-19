import 'package:flutter/material.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});
  static const route = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),
                ]),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.right,
              softWrap: true,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.grey,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
