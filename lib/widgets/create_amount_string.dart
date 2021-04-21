  
import 'package:tastebudsdelightfront/data/amount_fraction.dart';
import 'package:tastebudsdelightfront/data/ingredient.dart';

String createAmountString(Ingredient ingredient) {
    if (ingredient.amount.toInt() == 0) {
      return ingredient.amountFraction;
    }
    if (ingredient.amountFraction == AmountFraction.list[0]) {
      return '${ingredient.amount.toInt()}';
    }
    return '${ingredient.amount.toInt()} ${ingredient.amountFraction}';
  }