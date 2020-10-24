import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItem(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Text(recipe.overview.title),
    );
  }
}
