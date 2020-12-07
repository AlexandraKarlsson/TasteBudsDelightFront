import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cooking_ingredient_row.dart';
import '../../../data/cooking/cooking_ingredients.dart';
import '../../../data/ingredients.dart';

class CookingIngredientTable extends StatelessWidget {
  final Ingredients ingredients;

  CookingIngredientTable(this.ingredients);

  Table _getAllIngredientTableRows(BuildContext context) {
    CookingIngredients cookingIngredients =
        Provider.of<CookingIngredients>(context);
    List<TableRow> tableRowList = [];

    ingredients.ingredientList.asMap().forEach((index, ingredient) {
      TableRow row = createCookingIngredientRow(
          ingredient,
          cookingIngredients.cookingIngredientList[index],
          index,
          cookingIngredients);
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
