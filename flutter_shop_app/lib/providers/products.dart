import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:great_places_app/providers/product.dart';
import '../models/https_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'title',
    //     description:
    //         'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
    //     price: 22.42,
    //     imageUrl:
    //         'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
    //     isFavourite: false),
    // Product(
    //     id: 'p2',
    //     title: 'titlerrtrt',
    //     description:
    //         'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
    //     price: 22.42,
    //     imageUrl:
    //         'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
    //     isFavourite: false),
    // Product(
    //     id: 'p3',
    //     title: 'titlfdfdfde',
    //     description:
    //         'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
    //     price: 22.42,
    //     imageUrl:
    //         'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
    //     isFavourite: false),
    // Product(
    //     id: 'p4',
    //     title: 'titlfdfdfdfe',
    //     description:
    //         'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
    //     price: 22.42,
    //     imageUrl:
    //         'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
    //     isFavourite: false),
    // Product(
    //     id: 'p5',
    //     title: 'titlfdfdfddsdssfe',
    //     description:
    //         'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
    //     price: 22.42,
    //     imageUrl:
    //         'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
    //     isFavourite: false),
  ];

  List<Product> get items => [..._items];

  List<Product> get favouriteItems =>
      _items.where((element) => element.isFavourite).toList();

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      responseData.forEach(
        (key, value) {
          loadedProducts.add(Product(
              id: key,
              title: value['title'],
              description: value['description'],
              price: value['price'],
              imageUrl: value['imageUrl'],
              isFavourite: value['isFavourite']));
        },
      );
      _items = loadedProducts;
      notifyListeners();
      print((responseData));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItem(Product editedProduct) async {
    const url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': editedProduct.title,
          'description': editedProduct.description,
          'imageUrl': editedProduct.imageUrl,
          'price': editedProduct.price,
          'isFavourite': false
        }),
      );
      final newProduct = Product(
          title: editedProduct.title,
          price: editedProduct.price,
          description: editedProduct.description,
          imageUrl: editedProduct.imageUrl,
          isFavourite: editedProduct.isFavourite,
          id: DateTime.now().toString());
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void updateItem(Product editedProduct, String productId) async {
    final index = _items.indexWhere((element) => element.id == productId);
    if (index >= 0) {
      final url =
          'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productId.json';
      try {
        await http.patch(Uri.parse(url),
            body: json.encode({
              'title': editedProduct.title,
              'description': editedProduct.description,
              'imageUrl': editedProduct.imageUrl,
              'price': editedProduct.price,
            }));
        _items[index] = editedProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    // ignore: prefer_const_declarations
    final url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
