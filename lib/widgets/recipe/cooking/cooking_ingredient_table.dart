import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/ingredients.dart';

import 'cooking_ingredient_row.dart';

class CookingIngredientTable extends StatelessWidget {
  final Ingredients ingredients;

  CookingIngredientTable(this.ingredients);

  Table _getAllIngredientTableRows(BuildContext context) {
    List<TableRow> tableRowList = [];
    ingredients.ingredientList.forEach((ingredient) {
      TableRow row = createCookingIngredientRow(ingredient);
      tableRowList.add(row);
    });
    Table table = Table(columnWidths: {
      0: IntrinsicColumnWidth(),
      1: IntrinsicColumnWidth(),
      2: IntrinsicColumnWidth(),
      3: IntrinsicColumnWidth(),
    }, children: <TableRow>[
      ...tableRowList,
    ]);
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Ingredienser',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        _getAllIngredientTableRows(context),
      ],
    );
  }
}
