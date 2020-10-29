import 'package:flutter/material.dart';
import '../../data/recipe_item.dart';

class RecipeListItem extends StatelessWidget {
  final RecipeItem recipeItem;

  const RecipeListItem(this.recipeItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          // TODO: Add navigation to detailed page of the recipe.
          // Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (BuildContext context) => DetailedRecipeItem(home)));
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
