import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/ingredient.dart';

TableRow createIngredientRow(Ingredient ingredient) {
  return TableRow(
    children: <Widget>[
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

TableRow createIngredientCookingRow(Ingredient ingredient) {
  return TableRow(
    children: <Widget>[
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
