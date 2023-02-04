import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meal_app/models/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {super.key, required this.currentFilters, required this.filters});

  static const routeName = '/filters';
  final Function filters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
        subtitle: Text(description),
        value: currentValue,
        onChanged: ((value) {
          updateValue(value);
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.filters(selectedFilters);
              print('saved');
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Filters',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            _buildSwitchListTile(
                'Gluten free', 'Only include gluten free meals', _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            _buildSwitchListTile(
                'Lactose free', 'Only include lactose free meals', _lactoseFree,
                (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            _buildSwitchListTile(
                'Vegetarian', 'Only include Vegetarian meals', _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            _buildSwitchListTile('Vegan', 'Only include Vegan meals', _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
          ],
        ))
      ]),
    );
  }
}
