import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/ingredients.dart';

class IngredientTable extends StatelessWidget {
  final Ingredients ingredients;

  IngredientTable(this.ingredients);

  Table _getAllIngredientTableRows() {
    List<TableRow> tableRowList = [];
    ingredients.ingredientList.forEach((ingredient) {
      TableRow row = TableRow(
        children: <Widget>[
          TableCell(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
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
              padding:
                  const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
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
              padding:
                  const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 2),
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
        _getAllIngredientTableRows(),
      ],
    );
  }
}
