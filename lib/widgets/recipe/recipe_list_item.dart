import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/pages/detailed_recipe.dart';
import '../../data/recipe_item.dart';

class RecipeListItem extends StatelessWidget {
  final RecipeItem recipeItem;

  RecipeListItem(this.recipeItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DetailedRecipe(recipeItem.id)));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                  'http://10.0.2.2:8010/images/${recipeItem.imageFileName}'),
            ),
            Text(
              recipeItem.title,
              style: TextStyle(fontSize: 16),
            ),
            Text('${recipeItem.time.toString()} min'),
            Text('${recipeItem.portions.toString()} portioner'),
          ],
        ),
      ),
    );
  }
}
