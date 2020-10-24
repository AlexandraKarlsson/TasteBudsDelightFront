import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/recipes.dart';
import 'package:tastebudsdelightfront/pages/add_recipe.dart';
import '../widgets/styles.dart';
import '../widgets/recipe/recipe_list_item.dart';

const textStyle = TextStyle(fontSize: 25);

class RecipeList extends StatefulWidget {
  static const PATH = '/recipe_list';

  RecipeList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    Recipes recipes = Provider.of<Recipes>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Bilder', style: optionStyle),
          // ),
          Container(
            child: Expanded(
              child: GridView.builder(
                itemCount: recipes.recipeList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return RecipeListItem(recipes.recipeList[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRecipe.PATH);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
