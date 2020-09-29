import 'package:flutter/material.dart';
import '../../pages/edit_ingredient.dart';
import '../../data/ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final index;
  final Function delete;

  IngredientItem(this.delete, this.index, this.ingredient);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.edit),
        title: Text(ingredient.name),
        subtitle: Text(ingredient.amount.toString() + ' ' + ingredient.unit),
        trailing: InkWell(
          child: Icon(Icons.delete),
          onTap: () {
            print('Delete ingredient ...');
            delete(index);
          },
        ),
        onTap: () {
          print('Edit ingredient ...');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditIngredient(index)));
        },
      ),
    );
  }
}
