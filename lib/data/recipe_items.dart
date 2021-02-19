import 'package:flutter/material.dart';

import 'recipe_item.dart';

class RecipeItems extends ChangeNotifier {
  List<RecipeItem> recipeItemList = [];

  // add(RecipeItem recipeItem) {
  //   recipeItemList.add(recipeItem);
  //   notifyListeners();
  // }

  parseAndAdd(Map<String, dynamic> responseData) {
    recipeItemList = [];
    responseData['recipes'].forEach(
      (recipe) {
        int id = recipe['recipeid'];
        String imageFileName = recipe['name'];
        String title = recipe['title'];
        String description = recipe['description'];
        int time = recipe['time'];
        int portions = recipe['portions'];
        bool isVegan = recipe['isvegan'] == 0 ? false : true;
        bool isVegetarian = recipe['isvegetarian'] == 0 ? false : true;
        bool isGlutenFree = recipe['isglutenfree'] == 0 ? false : true;
        bool isLactoseFree = recipe['islactosefree'] == 0 ? false : true;
        String username = recipe['username'];

        RecipeItem newRecipeItem = RecipeItem(
          id,
          imageFileName,
          title,
          description,
          time,
          portions,
          isVegan,
          isVegetarian,
          isGlutenFree,
          isLactoseFree,
          username
        );
        recipeItemList.add(newRecipeItem);
        notifyListeners();
      },
    );
  }
}
