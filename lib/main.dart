import 'package:flutter/material.dart';

import 'pages/recipes_list.dart';
import 'pages/add_recipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smaklökarnas Frestelser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RecipesList(title: 'Marinas Recept'),
      routes: {
        RecipesList.PATH:  (context) => RecipesList(), 
        AddRecipe.PATH: (context) => AddRecipe(),
      }
    );
  }
}


