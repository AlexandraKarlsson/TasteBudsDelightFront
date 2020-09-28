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

  delete(index) {
    Ingredients ingredients =
        Provider.of<Ingredients>(context,listen: false);
     ingredients.deleteIngredient(index);
  }

  @override
  Widget build(BuildContext context) {
    Ingredients ingredients =
        Provider.of<Ingredients>(context);
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
                return IngredientItem(
                    delete, index, ingredients.ingredientList[index]);
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
                    Ingredient(0, IngredientUnit.unitList[0], 'Ny indgrediens');
                setState(() {
                  ingredients.ingredientList.add(ingredient);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
