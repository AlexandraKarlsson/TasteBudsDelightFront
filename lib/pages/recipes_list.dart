import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/pages/add_recipe.dart';

const textStyle = TextStyle(fontSize: 25);

class RecipesList extends StatefulWidget {
  static const PATH = '/recipes_list';

  RecipesList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
          Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Recept 1',style: textStyle),
            Text('Recept 2',style: textStyle),
            Text('Recept 3',style: textStyle),
          ],
            ),
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
