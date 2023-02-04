import 'package:flutter/material.dart';
import 'package:flutter_meal_app/data/dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavourite;
  final Function isFavourite;

  const MealDetailScreen(
      {super.key, required this.toggleFavourite, required this.isFavourite});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildContainer(
      Widget child, double height, double margin, double padding) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: padding),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            height: 250,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle('Ingredients'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    selectedMeal.ingredients[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
            200,
            20,
            10,
          ),
          buildSectionTitle('Steps'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    title: Text(selectedMeal.steps[index],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
            300,
            5,
            0,
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.toggleFavourite(mealId);
            print('favorite');
          },
          child: widget.isFavourite(mealId)
              ? Icon(Icons.star)
              : Icon(Icons.star_border)),
    );
  }
}
