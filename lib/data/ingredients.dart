import 'package:flutter/material.dart';

import 'ingredient.dart';

class Ingredients extends ChangeNotifier {
  List<Ingredient> ingredientList = [];

  static Ingredients clone(Ingredients ingredients) {
    Ingredients newIngredients = Ingredients();
    ingredients.ingredientList.forEach((ingredient) {
      newIngredients.add(ingredient.amount, ingredient.amountFraction, ingredient.unit, ingredient.name);
    });
    return newIngredients;
  }

  add(double amount, String amountFraction, String unit, String name) {
    Ingredient ingredient = Ingredient(amount, amountFraction, unit, name);
    ingredientList.add(ingredient);
    notifyListeners();
  }

  addIngredient(Ingredient ingredient) {
    ingredientList.add(ingredient);
    notifyListeners();
  }

  delete(index) {
    ingredientList.removeAt(index);
    notifyListeners();
  }

  moveDown(itemSelected) {
    Ingredient selectedIngredient = ingredientList.elementAt(itemSelected);
    Ingredient belowIngredient = ingredientList.elementAt(itemSelected + 1);
    ingredientList[itemSelected] = belowIngredient;
    ingredientList[itemSelected + 1] = selectedIngredient;
    notifyListeners();
  }

  moveUp(itemSelected) {
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

  setAmountFraction(index, fraction) {
    ingredientList[index].amountFraction = fraction;
    notifyListeners();
  }

  setUnit(index, unit) {
    print('index = $index, unit = $unit');
    ingredientList[index].unit = unit;
    notifyListeners();
  }

  List listOfIngredients() {
    List newIngredientsList = [];
    ingredientList.forEach((ingredient) {
      newIngredientsList.add({
        'amount': ingredient.amount,
        'amountfraction': ingredient.amountFraction,
        'unit': ingredient.unit,
        'name': ingredient.name
      });
    });
    return newIngredientsList;
  }

  clear() {
    ingredientList = [];
  }
}
