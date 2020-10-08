import 'package:flutter/material.dart';

class Overview extends ChangeNotifier {
  String title = "";
  String description = "";
  int time = 0;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isGlutenFree = false;
  bool isLactoseFree = false;

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
}
