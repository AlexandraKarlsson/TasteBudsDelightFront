import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/ingredient.dart';
import '../../data/ingredient_unit.dart';
import '../../data/ingredients.dart';
import '../styles.dart';
import 'ingredient_item.dart';

class IngredientsTab extends StatefulWidget {
  @override
  _IngredientsTabState createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  int itemSelected = -1;

  delete(index) {
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    ingredients.deleteIngredient(index);
  }

  select(index) {
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
    //List<Ingredient> ingredientList = ingredients.ingredientList;
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
              itemCount: ingredients.ingredientList.length,
              itemBuilder: (BuildContext context, int index) {
                return IngredientItem(itemSelected, index,
                    ingredients.ingredientList[index], select, delete);
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
                  ingredients.ingredientList.add(ingredient);
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
              onPressed: (ingredients.ingredientList.length <= 1) ||
                      (itemSelected == 0)
                  ? null
                  : () {
                      print('Move ingredient up');
                    },
            ),
            SizedBox(width: 7),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              iconSize: 35,
              onPressed: (ingredients.ingredientList.length <= 1) ||
                      (itemSelected == ingredients.ingredientList.length - 1)
                  ? null
                  : () {
                      print('Move ingredient down');
                    },
            ),
          ],
        ),
      ],
    );
  }
}

