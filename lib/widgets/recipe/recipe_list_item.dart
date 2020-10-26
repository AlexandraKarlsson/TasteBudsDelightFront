import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItem(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          // TODO: Add navigation to detailed page of the recipe.
        },
        child: Column(
          children: <Widget>[
            //Image.network(recipe.images.imageList[0].file),
            Text(recipe.overview.title),
          ],
        ),
      ),
    );
  }
}
