import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:great_places_app/providers/product.dart';
import '../models/https_exception.dart';

class Products with ChangeNotifier {
  final String? token;
  final String? uid;

  List<Product> _items = [];

  Products(this.token, this._items, this.uid);

  List<Product> get items => [..._items];

  List<Product> get favouriteItems =>
      _items.where((element) => element.isFavourite).toList();

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$uid"' : '';
    var url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$token&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      url =
          'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/userFavourites/$uid.json?auth=$token';
      var favouriteResponse = await http.get(Uri.parse(url));
      var favouriteData = json.decode(favouriteResponse.body);
      final List<Product> loadedProducts = [];
      responseData.forEach(
        (key, value) {
          loadedProducts.add(Product(
              id: key,
              title: value['title'],
              description: value['description'],
              price: value['price'],
              imageUrl: value['imageUrl'],
              isFavourite: favouriteData == null
                  ? false
                  : favouriteData[key] == null
                      ? false
                      : favouriteData[key]['isFavourite']));
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItem(Product editedProduct) async {
    var url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$token';
    try {
      await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': editedProduct.title,
          'description': editedProduct.description,
          'imageUrl': editedProduct.imageUrl,
          'price': editedProduct.price,
          'creatorId': uid
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
          'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productId.json?auth=$token';
      try {
        await http.patch(Uri.parse(url),
            body: json.encode({
              'title': editedProduct.title,
              'description': editedProduct.description,
              'imageUrl': editedProduct.imageUrl,
              'price': editedProduct.price,
              'creatorId': uid
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
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$token';

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
