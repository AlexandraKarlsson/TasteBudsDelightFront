import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/ingredient.dart';

TableRow createCookingIngredientRow(Ingredient ingredient) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: SizedBox(height:27,width: 30,
            child: Checkbox(
            value: false /* Use provider later*/,
            onChanged: (value) {
              print('Ingredient - toggle checkbox!');
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
