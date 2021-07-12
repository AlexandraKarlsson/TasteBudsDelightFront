import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/setting_data.dart';
import '../../../data/recipe_item.dart';
import '../../../pages/recipe_detailed.dart';

class RecipeListItem extends StatelessWidget {
  final RecipeItem recipeItem;

  RecipeListItem(this.recipeItem);

  @override
  Widget build(BuildContext context) {
    SettingData setting = Provider.of<SettingData>(context);

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
                        RecipeDetailed(recipeItem.id, recipeItem.userId)));
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                      'http://${setting.imageAddress}:${setting.imagePort}/images/${recipeItem.imageFileName}'),
                ),
                SizedBox(height: 3),
                Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      recipeItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          size: 18,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${recipeItem.time.toString()} min',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          size: 18,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${recipeItem.portions.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  'Av: ${recipeItem.username}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
