import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:great_places_app/models/https_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.isFavourite});

  Future<void> changeFavourite() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url =
        'https://shop-a25ed-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    final code = await http.patch(Uri.parse(url),
        body: json.encode({'isFavourite': isFavourite}));
    if (code.statusCode >= 400) {
      isFavourite = oldStatus;
      notifyListeners();
      throw HttpException('could not like');
    }
  }
}
