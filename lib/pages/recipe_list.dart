// import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../data/recipe_items.dart';
import 'add_recipe.dart';
import '../widgets/recipe/recipe_list_item.dart';

// Move to style.dart file?
const textStyle = TextStyle(fontSize: 25);

class RecipeList extends StatefulWidget {
  static const PATH = '/recipe_list';

  RecipeList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    _fetchRecipes().then((_) {
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> _fetchRecipes() async {
    const url = 'http://10.0.2.2:8000/tastebuds/recipe';

    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body) as Map<String, dynamic>;
      RecipeItems recipeItems =
          Provider.of<RecipeItems>(context, listen: false);
      recipeItems.parseAndAdd(responseData);
    } else {
      print('_fetchingRecipes() status code = ${response.statusCode}!');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      RecipeItems recipeItems = Provider.of<RecipeItems>(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(6),
                  itemCount: recipeItems.recipeItemList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeListItem(recipeItems.recipeItemList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[600],
          onPressed: () {
            Navigator.pushNamed(context, AddRecipe.PATH);
          },
          tooltip: 'Lägg till nytt recept!',
          child: Icon(Icons.add,),
        ),
      );
    }
  }
}
