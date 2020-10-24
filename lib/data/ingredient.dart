import '../data/ingredient_unit.dart';

class Ingredient {
  double amount;
  String unit;
  String name;

  Ingredient(this.amount, this.unit, this.name);

  static Ingredient clone(Ingredient ingredient) {
    Ingredient newIngredient =
        Ingredient(ingredient.amount, ingredient.unit, ingredient.name);
    return newIngredient;
  }

  init() {
    amount = 0;
    unit = IngredientUnit.unitList[0];
    name = "";
  }

  clear() {
    init();
  }
}
