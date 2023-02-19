import 'package:flutter/cupertino.dart';
import 'package:great_places_app/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'p1',
        title: 'title',
        description:
            'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
        price: 22.42,
        imageUrl:
            'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
        isFavourite: false),
    Product(
        id: 'p2',
        title: 'titlerrtrt',
        description:
            'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
        price: 22.42,
        imageUrl:
            'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
        isFavourite: false),
    Product(
        id: 'p3',
        title: 'titlfdfdfde',
        description:
            'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
        price: 22.42,
        imageUrl:
            'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
        isFavourite: false),
    Product(
        id: 'p4',
        title: 'titlfdfdfdfe',
        description:
            'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
        price: 22.42,
        imageUrl:
            'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
        isFavourite: false),
    Product(
        id: 'p5',
        title: 'titlfdfdfddsdssfe',
        description:
            'Now, think about what those things do for your customer. Does careful construction mean that your product is safe for children? Do ethically sourced materials make the buyer feel good about purchasing your product? Do those bells and whistles make everyone who sees your customer with your product weep with envy? Those are benefits.',
        price: 22.42,
        imageUrl:
            'https://img.uhdpaper.com/wallpaper/pantheon-runeterra-targon-639@1@e-preview.jpg?dl',
        isFavourite: false),
  ];

  List<Product> get items => [..._items];

  List<Product> get favouriteItems =>
      _items.where((element) => element.isFavourite).toList();

  void addItem() {
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
