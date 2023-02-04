import 'package:flutter/material.dart';
import 'package:flutter_meal_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.bottomRight,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(20),
          child: Text(
            'Let him cook',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 60,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildListTile('Meals', Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Filters', Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
      ]),
    );
  }
}
