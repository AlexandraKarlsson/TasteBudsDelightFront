import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/recipe_item.dart';

class SearchData extends ChangeNotifier {
  String title = "";
//   String description;
//   int time;
//   int portions;
//   bool isVegan;
//   bool isVegetarian;
//   bool isGlutenFree;
//   bool isLactoseFree;

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  List<RecipeItem> filter(List<RecipeItem> list) {
    List<RecipeItem> filteredList = [];
    list.forEach((recipe) {
      if(recipe.title.toLowerCase().contains(title.toLowerCase())){
        filteredList.add(recipe);
      }
    });
    return filteredList;
  }
}
