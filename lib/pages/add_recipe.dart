import 'package:flutter/material.dart';

import '../widgets/recipe/ingredients_tab.dart';
import '../widgets/recipe/overview_tab.dart';

class AddRecipe extends StatefulWidget {
  static const PATH = '/add_recipe';

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    OverviewTab(),
    IngredientsTab(),
    Text(
      'Index 2: Beskriving',
    ),
    Text(
      'Index 3: Bild',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skapa recept')),
      body: Container(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[400],
        items: const <BottomNavigationBarItem> [          
          BottomNavigationBarItem(
            title: Text('Översikt'),
            icon: Icon(Icons.border_color),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            title: Text('Ingredienser'),
            icon: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            title: Text('Beskrivnig'),
            icon: Icon(Icons.format_list_bulleted),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            title: Text('Bild'),
            icon: Icon(Icons.add_photo_alternate),
            backgroundColor: Colors.black
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
