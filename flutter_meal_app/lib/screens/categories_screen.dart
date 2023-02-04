import 'package:flutter/material.dart';
import 'package:flutter_meal_app/models/widgets/category_item.dart';
import 'package:flutter_meal_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      children: DUMMY_CATEGORIES.map((e) {
        return CategoryItem(
          id: e.id,
          title: e.title,
          color: e.color,
        );
      }).toList(),
    );
  }
}
