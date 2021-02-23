import 'package:flutter/material.dart';

import 'filter_option.dart';
import '../data/recipe_item.dart';

class SearchData extends ChangeNotifier {
  String title = "";
//   String description;
//   int time;
//   int portions;
  List<FilterOption> optionList = [];

  static const int VEGAN_INDEX = 0;
  static const int VEGETARIAN_INDEX = 1;
  static const int LACTOSEFREE_INDEX = 2;
  static const int GLUTENFREE_INDEX = 3;
  static const int ONLYOWNRECIPE_INDEX = 4;

  SearchData() {
    optionList.add(FilterOption('Veganskt'));
    optionList.add(FilterOption('Vegetariskt'));
    optionList.add(FilterOption('Laktosfri'));
    optionList.add(FilterOption('Glutenfri'));
    optionList.add(FilterOption('Egna recept'));
  }

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void setFilterOption(int index, bool newState) {
    optionList[index].value = newState;
    notifyListeners();
  }

  // void setOnlyOwnRecipe(bool newState) {
  //   optionList[ONLYOWNRECIPE_INDEX].value = newState;
  //   print('onlyOwnRecipe = ${optionList[ONLYOWNRECIPE_INDEX].value}');
  //   notifyListeners();
  // }

  List<RecipeItem> filter(List<RecipeItem> list, int userId) {
    List<RecipeItem> filteredList = [];

    list.forEach(
      (recipe) {
        if (recipe.title.toLowerCase().contains(title.toLowerCase())) {
          bool checkOneOk = true;
          bool checkTwoOk = true;
          bool checkThreeOk = true;
          bool checkFourOk = true;
          bool checkOwnRecipeOk = true;

          if (optionList[ONLYOWNRECIPE_INDEX].value == true) {
            if (recipe.userId != userId) {
              checkOwnRecipeOk = false;
            }
          }

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

          if (checkOneOk &&
              checkTwoOk & checkThreeOk &&
              checkFourOk &&
              checkOwnRecipeOk) {
            filteredList.add(recipe);
          }
        }
      },
    );
    return filteredList;
  }
}
