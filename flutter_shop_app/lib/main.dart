import 'package:flutter/material.dart';
import 'package:great_places_app/providers/auth.dart';
import 'package:great_places_app/providers/cart.dart';
import 'package:great_places_app/providers/orders.dart';
import 'package:great_places_app/providers/products.dart';
import 'package:great_places_app/screens/auth_screen.dart';
import 'package:great_places_app/screens/cart_screen.dart';
import 'package:great_places_app/screens/edit_products_screen.dart';
import 'package:great_places_app/screens/order_screen.dart';
import 'package:great_places_app/screens/product_detail_screen.dart';
import 'package:great_places_app/screens/products_overview_screen.dart';
import 'package:great_places_app/screens/splash_screen.dart';
import 'package:great_places_app/screens/user_products_screen.dart';
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
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: ((context) => Products(null, [], null)),
          update: (BuildContext context, value, Products? previous) {
            return Products(value.token, previous!.items, value.getUserId);
          },
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders([], null, null),
          update: (BuildContext context, value, Orders? previous) {
            return Orders(previous!.orders, value.token, value.getUserId);
          },
        )
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) {
        return MaterialApp(
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
                  .copyWith(secondary: const Color.fromARGB(255, 32, 75, 202))),
          home: auth.isAuth
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          // initialRoute: '/',
          routes: {
            // AuthScreen.route: (context) => const AuthScreen(),
            // ProductsOverviewScreen.route: (context) => const ProductsOverviewScreen(),
            ProductDetailScreen.route: (context) => const ProductDetailScreen(),
            CartScreen.route: (context) => const CartScreen(),
            OrderScreen.route: (context) => const OrderScreen(),
            UserProductScreen.route: (context) => const UserProductScreen(),
            EditProductsScreen.route: (context) => const EditProductsScreen()
          },
        );
      }),
    );
  }
}
