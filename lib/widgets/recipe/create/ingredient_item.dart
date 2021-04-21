import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/widgets/create_amount_string.dart';

import '../../../data/ingredient.dart';
import '../../../pages/edit_ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final index;
  final itemSelected;
  final Function delete;
  final Function select;

  IngredientItem(this.itemSelected, this.index, this.ingredient,this.select, this.delete);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index == itemSelected ? Colors.red[400] : Theme.of(context).cardColor,
      elevation: 5,
      child: ListTile(
        leading: InkWell(
          child: Icon(Icons.edit),
          onTap: () {
            // print('Edit ingredient ...');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditIngredient(index)));
          },
        ),
        title: Text(ingredient.name),
        subtitle: Text(createAmountString(ingredient) + ' ' + ingredient.unit),
        trailing: InkWell(
          child: Icon(Icons.delete),
          onTap: () {
            // print('Delete ingredient ...');
            delete(index);
          },
        ),
        onTap: () {
          select(index);
        },
      ),
    );
  }
}
