import 'package:flutter/material.dart';

class Overview extends ChangeNotifier {
  int recipeId;
  String title;
  String description;
  int time;
  int portions;
  bool isVegan;
  bool isVegetarian;
  bool isGlutenFree;
  bool isLactoseFree;

  Overview() {
    init();
  }

  init() {
    recipeId = -1;
    title = "";
    description = "";
    time = 0;
    portions = 0;
    isVegan = false;
    isVegetarian = false;
    isGlutenFree = false;
    isLactoseFree = false;
  }

  setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  setTime(int time) {
    this.time = time;
    notifyListeners();
  }

  setPortions(int portions) {
    this.portions = portions;
    notifyListeners();
  }

  setIsVegan(bool isVegan) {
    this.isVegan = isVegan;
    notifyListeners();
  }

  setIsVegetarian(bool isVegetarian) {
    this.isVegetarian = isVegetarian;
    notifyListeners();
  }

  setIsGlutenFree(bool isGlutenFree) {
    this.isGlutenFree = isGlutenFree;
    notifyListeners();
  }

  setIsLactoseFree(bool isLactoseFree) {
    this.isLactoseFree = isLactoseFree;
    notifyListeners();
  }

  clear() {
    init();
  }
}
