import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ingredient_item.dart';
import '../styles.dart';
import '../../data/ingredient.dart';
import '../../data/ingredient_unit.dart';
import '../../data/ingredients.dart';

class IngredientsTab extends StatefulWidget {
  @override
  _IngredientsTabState createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  int itemSelected = -1;

  delete(index) {
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    ingredients.delete(index);
  }

  select(index) {
    print('itemSelected=$itemSelected, index=$index');
    if (index == itemSelected) {
      setState(() {
        itemSelected = -1;
      });
    } else {
      setState(() {
        itemSelected = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Ingredients ingredients = Provider.of<Ingredients>(context);
    List<Ingredient> ingredientList = ingredients.ingredientList;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Ingredienser', style: optionStyle),
        ),
        Container(
          child: Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: ingredientList.length,
              itemBuilder: (BuildContext context, int index) {
                return IngredientItem(
                    itemSelected, index, ingredientList[index], select, delete);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Ingredient ingredient =
                    Ingredient(0, IngredientUnit.unitList[0], 'Ny ingrediens');
                setState(() {
                  ingredientList.add(ingredient);
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              iconSize: 35,
              onPressed: (ingredientList.length <= 1) || (itemSelected == 0)
                  ? null
                  : () {
                      print('Move ingredient up');
                      ingredients.moveUp(itemSelected);
                      setState(() {
                        itemSelected = itemSelected - 1;
                      });
                    },
            ),
            SizedBox(width: 7),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              iconSize: 35,
              onPressed: (ingredientList.length <= 1) ||
                      (itemSelected == ingredientList.length - 1)
                  ? null
                  : () {
                      print('Move ingredient down');
                      ingredients.moveDown(itemSelected);
                      setState(() {
                        itemSelected = itemSelected + 1;
                      });
                    },
            ),
          ],
        ),
      ],
    );
  }
}
