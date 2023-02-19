import 'package:flutter/material.dart';
import 'package:great_places_app/providers/cart.dart';
import 'package:great_places_app/providers/orders.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/screens/cart_screen.dart';
import 'package:great_places_app/screens/order_screen.dart';
import 'package:great_places_app/screens/product_detail_screen.dart';
import 'package:great_places_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Products())),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  headline4: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  headline6: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  headline1: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Color.fromARGB(255, 32, 75, 202))),
        // home: const ProductsOverviewScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const ProductsOverviewScreen(),
          ProductDetailScreen.route: (context) => const ProductDetailScreen(),
          CartScreen.route: (context) => const CartScreen(),
          OrderScreen.route: (context) => const OrderScreen()
        },
      ),
    );
  }
}
