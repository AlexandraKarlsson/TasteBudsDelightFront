import 'package:flutter/material.dart';

class CookingRecipe extends ChangeNotifier {
  int _id = -1;
  bool timerOn = false;
  // int time;

  void newRecipe(int recipeId) {
    _id = recipeId;
    timerOn = false;
    // TODO: update timer
    // notifyListeners();
  }

  bool isNewId(int newId) { return newId != _id ? true : false; }
}

