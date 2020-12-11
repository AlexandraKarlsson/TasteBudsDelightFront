import 'package:flutter/material.dart';

import 'ingredient_row.dart';

import '../../../data/ingredients.dart';

class IngredientTable extends StatelessWidget {
  final Ingredients ingredients;

  IngredientTable(this.ingredients);

  Table _getAllIngredientTableRows(BuildContext context) {
    List<TableRow> tableRowList = [];
    ingredients.ingredientList.forEach((ingredient) {
      TableRow row = createIngredientRow(ingredient);
      tableRowList.add(row);
    });
    Table table = Table(columnWidths: {
      0: IntrinsicColumnWidth(),
      1: IntrinsicColumnWidth(),
      2: IntrinsicColumnWidth(),
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
