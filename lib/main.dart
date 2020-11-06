import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/recipes.dart';
import 'package:tastebudsdelightfront/pages/detailed_recipe.dart';

import 'data/images.dart';
import 'data/ingredients.dart';
import 'data/overview.dart';
import 'data/recipe_items.dart';
import 'data/instructions.dart';
import 'pages/recipe_list.dart';
import 'pages/add_recipe.dart';
import 'pages/add_image.dart';

// Starting the emulator
// emulator.exe -avd Pixel_2_API_28

// Activate dev tools
// pub global activate devtools
/******************************************/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Overview>(create: (_) => Overview()),
        ChangeNotifierProvider<Ingredients>(create: (_) => Ingredients()),
        ChangeNotifierProvider<Instructions>(create: (_) => Instructions()),
        ChangeNotifierProvider<Images>(create: (_) => Images()),
        ChangeNotifierProvider<RecipeItems>(create: (_) => RecipeItems()),
      ],
      child: MaterialApp(
          title: 'Smaklökarnas Frestelser',
          theme: ThemeData(
           //  primarySwatch: Colors.red,
           primaryColor: Colors.red[400],
           //floatingActionButtonTheme: ,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: RecipeList(title: 'Marinas Recept'),
          routes: {
            RecipeList.PATH: (context) => RecipeList(),
            AddRecipe.PATH: (context) => AddRecipe(),
            AddImage.PATH: (context) => AddImage(),
            // DetailedRecipe.PATH: (context) => DetailedRecipe(),
          }),
    );
  }
}
