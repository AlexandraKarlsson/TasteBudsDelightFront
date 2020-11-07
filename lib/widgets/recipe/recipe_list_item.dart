import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/pages/detailed_recipe.dart';
import '../../data/recipe_item.dart';

class RecipeListItem extends StatelessWidget {
  final RecipeItem recipeItem;

  RecipeListItem(this.recipeItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailedRecipe(recipeItem.id)));
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                      'http://10.0.2.2:8010/images/${recipeItem.imageFileName}'),
                ),
                SizedBox(
                  height: 3
                ),
                Text(
                  recipeItem.title,
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer, size: 18,),
                        Text('${recipeItem.time.toString()} min', style: TextStyle(fontWeight: FontWeight.bold),), 
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.people, size: 20,),
                        Text('${recipeItem.portions.toString()}', style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Text('${recipeItem.time.toString()} min'),

                //     Text('${recipeItem.portions.toString()} portioner'),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
