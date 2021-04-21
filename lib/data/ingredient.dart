import 'ingredient_unit.dart';
import 'amount_fraction.dart';


class Ingredient {
  double amount;
  String amountFraction;
  String unit;
  String name;

  Ingredient(this.amount, this.amountFraction, this.unit, this.name);

  static Ingredient clone(Ingredient ingredient) {
    Ingredient newIngredient =
        Ingredient(ingredient.amount, ingredient.amountFraction, ingredient.unit, ingredient.name);
    return newIngredient;
  }

  init() {
    amount = 0;
    amountFraction = AmountFraction.list[0];
    unit = IngredientUnit.unitList[0];
    name = "";
  }

  clear() {
    init();
  }
}
