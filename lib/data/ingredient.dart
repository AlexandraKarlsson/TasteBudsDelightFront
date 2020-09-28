import '../data/ingredient_unit.dart';

class Ingredient {
  double amount = 0;
  String unit = IngredientUnit.unitList[0];
  String name = "";

  Ingredient(this.amount, this.unit, this.name);
}
