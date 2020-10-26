import 'package:flutter/material.dart';

class Overview extends ChangeNotifier {
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

  static Overview clone(Overview overview) {
    Overview newOverview = Overview();
    newOverview.title = overview.title;
    newOverview.description = overview.description;
    newOverview.time = overview.time;
    newOverview.portions = overview.portions;
    newOverview.isVegan = overview.isVegan;
    newOverview.isVegetarian = overview.isVegetarian;
    newOverview.isGlutenFree = overview.isGlutenFree;
    newOverview.isLactoseFree = overview.isLactoseFree;

    return newOverview;
  }

  init() {
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
