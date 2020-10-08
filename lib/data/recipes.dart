 import 'package:flutter/material.dart';

import '../data/recipe.dart';

class Recipes extends ChangeNotifier {
  List<Recipe> recipeList = [];

  add(Recipe recipe) {
    recipeList.add(recipe);
    notifyListeners();
  }
  
}