import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/cooking/cooking_ingredients.dart';
import 'package:tastebudsdelightfront/data/cooking/cooking_instructions.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'data/cooking/cooking_recipe.dart';
import 'data/images.dart';
import 'data/ingredients.dart';
import 'data/overview.dart';
import 'data/recipe_items.dart';
import 'data/instructions.dart';
import 'data/search_data.dart';
import 'pages/recipe_list.dart';
import 'pages/add_recipe.dart';
import 'pages/add_image.dart';

//----------------------------------
// Starting the emulator
// emulator.exe -avd Pixel_2_API_28

// Activate dev tools
// pub global activate devtools
//----------------------------------

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Overview>(create: (_) => Overview()),
        ChangeNotifierProvider<Ingredients>(create: (_) => Ingredients()),
        ChangeNotifierProvider<Instructions>(create: (_) => Instructions()),
        ChangeNotifierProvider<Images>(create: (_) => Images()),
        ChangeNotifierProvider<RecipeItems>(create: (_) => RecipeItems()),
        ChangeNotifierProvider<CookingRecipe>(create: (_) => CookingRecipe()),
        ChangeNotifierProvider<CookingIngredients>(create: (_) => CookingIngredients()),
        ChangeNotifierProvider<CookingInstructions>(create: (_) => CookingInstructions()),
        ChangeNotifierProvider<SearchData>(create: (_) => SearchData()),
      ],
      child: MaterialApp(
          title: 'Frestelser',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.red[400],
            accentColor: Colors.red[600],
            fontFamily: 'Nunito',
            
            //  primarySwatch: Colors.red,
            //floatingActionButtonTheme: ,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: RecipeList(title: 'Smaklökarnas Frestelser'),

          routes: {
            RecipeList.PATH: (context) => RecipeList(),
            AddRecipe.PATH: (context) => AddRecipe(),
            AddImage.PATH: (context) => AddImage(),
          }),
    );
  }
}
