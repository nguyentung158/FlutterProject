import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meal_app/models/meal.dart';
import 'package:flutter_meal_app/models/widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'No favourite meals found.',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: widget.favoriteMeals[index].id,
              title: widget.favoriteMeals[index].title,
              imageUrl: widget.favoriteMeals[index].imageUrl,
              duration: widget.favoriteMeals[index].duration,
              complexity: widget.favoriteMeals[index].complexity,
              affordability: widget.favoriteMeals[index].affordability,
            );
          },
          itemCount: widget.favoriteMeals.length);
    }
  }
}
