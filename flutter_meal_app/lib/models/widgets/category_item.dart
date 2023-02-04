import 'package:flutter/material.dart';
import 'package:flutter_meal_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.id, required this.title, required this.color});

  final String id;
  final String title;
  final Color color;

  void selectCategoryItem(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategoryItem(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
