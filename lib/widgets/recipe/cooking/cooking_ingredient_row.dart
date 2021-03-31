import 'package:flutter/material.dart';

import '../../../data/cooking/cooking_ingredients.dart';
import '../../../data/ingredient.dart';

TableRow createCookingIngredientRow(
    Ingredient ingredient,
    CookingIngredient cookingIngredient,
    int index,
    CookingIngredients cookingIngredients) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: SizedBox(
          height: 27,
          width: 30,
          child: Checkbox(
            activeColor: Colors.green,
            value: cookingIngredient.isUsed,
            onChanged: (value) {
              print('Ingredient - toggle checkbox!');
              cookingIngredients.setIsUsed(index, value);
              // print('isUsed = ${cookingIngredient.isUsed}');
            },
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${ingredient.amount.toInt()}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
          child: Text(
            ingredient.unit,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 2),
          child: Text(
            ingredient.name,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
}


