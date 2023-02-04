import 'package:flutter/material.dart';
import 'package:flutter_meal_app/data/dummy_data.dart';
import 'package:flutter_meal_app/models/meal.dart';
import 'package:flutter_meal_app/models/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> categoryMeals;
  var categoryTitle;
  bool _isLoaded = false;

  void removeItem(String id) {
    setState(() {
      categoryMeals.removeWhere((element) => id == element.id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isLoaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id']!;
      categoryTitle = routeArgs['title']!;
      categoryMeals = widget.availableMeals.where(
        (element) {
          return element.categories.contains(categoryId);
        },
      ).toList();
    }
    _isLoaded = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
            );
          },
          itemCount: categoryMeals.length),
    );
  }
}
