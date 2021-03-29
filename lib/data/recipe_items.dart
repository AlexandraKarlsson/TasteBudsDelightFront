import 'package:flutter/material.dart';

import 'recipe_item.dart';

class RecipeItems extends ChangeNotifier {
  List<RecipeItem> recipeItemList = [];

  parseAndAdd(Map<String, dynamic> responseData) {
    recipeItemList = [];
    responseData['recipes'].forEach(
      (recipe) {
        int id = recipe['id'];
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
        int userId = recipe['userid'];

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
            username,
            userId);
        recipeItemList.add(newRecipeItem);
      },
    );
    notifyListeners();
  }

  deleteRecipe(int recipeId) {
    recipeItemList.removeWhere((recipeItem) => recipeItem.id == recipeId);
    notifyListeners();
  }
}
