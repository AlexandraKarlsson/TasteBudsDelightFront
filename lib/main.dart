import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'package:tastebudsdelightfront/pages/account_create.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'data/setting_data.dart';
import 'data/images.dart';
import 'data/ingredients.dart';
import 'data/overview.dart';
import 'data/recipe_items.dart';
import 'data/instructions.dart';
import 'data/search_data.dart';
import 'data/cooking/cooking_recipe.dart';
import 'data/cooking/cooking_ingredients.dart';
import 'data/cooking/cooking_instructions.dart';
import 'pages/account_login.dart';
import 'pages/settings_page.dart';
import 'pages/recipe_list.dart';
import 'pages/add_edit_recipe.dart';
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
        ChangeNotifierProvider<CookingIngredients>(
            create: (_) => CookingIngredients()),
        ChangeNotifierProvider<CookingInstructions>(
            create: (_) => CookingInstructions()),
        ChangeNotifierProvider<SearchData>(create: (_) => SearchData()),
        ChangeNotifierProvider<SettingData>(create: (_) => SettingData()),
        ChangeNotifierProvider<UserData>(create: (_) => UserData()),
      ],
      child: MaterialApp(
          title: 'Frestelse',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.red[400],
            accentColor: Colors.red[600],
            fontFamily: 'Nunito',
            textSelectionHandleColor: Colors.red[400],
            //  primarySwatch: Colors.red,
            //floatingActionButtonTheme: ,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          
          home: RecipeList(title: 'Smaklökarnas Frestelse'),
          routes: {
            RecipeList.PATH: (context) => RecipeList(),
            AddEditRecipe.PATH: (context) => AddEditRecipe(),
            AddImage.PATH: (context) => AddImage(),
            SettingsPage.PATH: (context) => SettingsPage(),
            AccountCreate.PATH: (context) => AccountCreate(),
            AccountLogin.PATH: (context) => AccountLogin(),
          }),
    );
  }
}
