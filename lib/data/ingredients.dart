import 'package:flutter/material.dart';

import 'ingredient.dart';

class Ingredients extends ChangeNotifier {
  List<Ingredient> ingredientList = [];

  static Ingredients clone(Ingredients ingredients) {
    Ingredients newIngredients = Ingredients();
    ingredients.ingredientList.forEach((ingredient) {
      newIngredients.add(ingredient.amount, ingredient.unit, ingredient.name);
     });
     return newIngredients;
  }

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

  moveIngredientDown(itemSelected) {
    Ingredient selectedIngredient = ingredientList.elementAt(itemSelected);
    Ingredient belowIngredient = ingredientList.elementAt(itemSelected + 1);
    ingredientList[itemSelected] = belowIngredient;
    ingredientList[itemSelected + 1] = selectedIngredient;
    notifyListeners();
  }

    moveIngredientUp(itemSelected) {
    Ingredient selectedIngredient = ingredientList.elementAt(itemSelected);
    Ingredient aboveIngredient = ingredientList.elementAt(itemSelected - 1);
    ingredientList[itemSelected] = aboveIngredient;
    ingredientList[itemSelected - 1] = selectedIngredient;
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

  clear() {
    ingredientList = [];
  }
}
