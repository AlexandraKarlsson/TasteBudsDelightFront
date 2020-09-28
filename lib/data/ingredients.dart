import 'package:flutter/material.dart';

import 'ingredient.dart';

class Ingredients extends ChangeNotifier {
  List<Ingredient> ingredientList = [];

  add(double amount, String unit, String name) {
    Ingredient ingredient = Ingredient(amount, unit, name);
    ingredientList.add(ingredient);
    notifyListeners();
  }

  addIngredient(Ingredient ingredient) {
    ingredientList.add(ingredient);
    notifyListeners();
  }

  deleteIngredient(index) {
    ingredientList.removeAt(index);
    notifyListeners();
  }

  setName(index, name) {
    ingredientList[index].name = name;
    notifyListeners();
  }

  setAmount(index, amount) {
    ingredientList[index].amount = amount;
    notifyListeners();
  }

  setUnit(index, unit) {
    print('index = $index, unit = $unit');
    ingredientList[index].unit = unit;
    notifyListeners();
  }
}
