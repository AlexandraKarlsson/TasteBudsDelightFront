import 'package:flutter/material.dart';

import '../ingredients.dart';

class CookingIngredient {
  bool isUsed = false;
}

class CookingIngredients extends ChangeNotifier {
  List<CookingIngredient> cookingIngredientList;

  void add(Ingredients ingredients) {
    cookingIngredientList = [];
    ingredients.ingredientList.forEach((_) { 
      cookingIngredientList.add(CookingIngredient());
    });
  }

  void setIsUsed(int index, bool value) {
    cookingIngredientList[index].isUsed = value;
    notifyListeners();
  }

}