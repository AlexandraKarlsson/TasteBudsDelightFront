import 'package:flutter/material.dart';

import '../data/recipe_item.dart';
import 'food_option.dart';

class SearchData extends ChangeNotifier {
  String title = "";
//   String description;
//   int time;
//   int portions;
  List<FoodOption> optionList = [];

  static const int VEGAN_INDEX = 0;
  static const int VEGETARIAN_INDEX = 1;
  static const int LACTOSEFREE_INDEX = 2;
  static const int GLUTENFREE_INDEX = 3;

  SearchData() {
    optionList.add(FoodOption('Veganskt'));
    optionList.add(FoodOption('Vegetariskt'));
    optionList.add(FoodOption('Laktosfri'));
    optionList.add(FoodOption('Glutenfri'));
  }

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void setFoodOption(int index, bool newState) {
    optionList[index].value = newState;
    notifyListeners();
  }

  List<RecipeItem> filter(List<RecipeItem> list) {
    List<RecipeItem> filteredList = [];
    list.forEach(
      (recipe) {
        if (recipe.title.toLowerCase().contains(title.toLowerCase())) {
          bool checkOneOk = true;
          bool checkTwoOk = true;
          bool checkThreeOk = true;
          bool checkFourOk = true;

          if (optionList[VEGAN_INDEX].value && !recipe.isVegan) {
            checkTwoOk = false;
          }

          if (optionList[VEGETARIAN_INDEX].value && !recipe.isVegetarian) {
            checkTwoOk = false;
          }

          if (optionList[LACTOSEFREE_INDEX].value && !recipe.isLactoseFree) {
            checkThreeOk = false;
          }

          if (optionList[GLUTENFREE_INDEX].value && !recipe.isGlutenFree) {
            checkFourOk = false;
          }

          if (checkOneOk && checkTwoOk & checkThreeOk && checkFourOk) {
            filteredList.add(recipe);
          }
        }
      },
    );
    return filteredList;
  }
}
