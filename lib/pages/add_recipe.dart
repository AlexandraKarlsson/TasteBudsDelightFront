import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/images.dart';
import 'package:tastebudsdelightfront/data/ingredient.dart';
import 'package:tastebudsdelightfront/data/ingredients.dart';
import 'package:tastebudsdelightfront/data/overview.dart';
import 'package:tastebudsdelightfront/data/recipe.dart';
import 'package:tastebudsdelightfront/data/recipes.dart';
import 'package:tastebudsdelightfront/data/steps.dart';

import '../widgets/recipe/images_tab.dart';
import '../widgets/recipe/steps_tab.dart';
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
    StepsTab(),
    ImagesTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _saveRecipe() {
    // Create recipe and add in recipes.
    Overview overview = Provider.of<Overview>(context,listen: false);
    Ingredients ingredients = Provider.of<Ingredients>(context,listen: false);
    Steps steps = Provider.of<Steps>(context,listen: false);
    Images images = Provider.of<Images>(context,listen: false);
    Recipes recipes = Provider.of<Recipes>(context,listen: false);
    
    recipes.add(Recipe(Overview.clone(overview), Ingredients.clone(ingredients), steps, images));

    // Clear all provider objects used for adding a recipe.
    overview.clear();
    ingredients.clear();
    // steps.clear();
    // images.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skapa recept'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: _saveRecipe)
        ],
      ),
      body: Container(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text('Översikt'),
              icon: Icon(Icons.border_color),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text('Ingredienser'),
              icon: Icon(Icons.add_shopping_cart),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text('Beskrivnig'),
              icon: Icon(Icons.format_list_bulleted),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text('Bild'),
              icon: Icon(Icons.add_photo_alternate),
              backgroundColor: Colors.black),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
