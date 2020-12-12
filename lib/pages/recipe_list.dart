import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'add_recipe.dart';
import '../data/setting_data.dart';
import '../data/recipe_item.dart';
import '../data/search_data.dart';
import '../data/recipe_items.dart';
import '../widgets/recipe/view/search.dart';
import '../widgets/recipe/view/recipe_list_item.dart';

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
  bool _showSearchBar = false;

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
    SettingData setting = Provider.of<SettingData>(context, listen: false);

    String url = 'http://${setting.serverAddress}:8000/tastebuds/recipe';

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
      SearchData searchData = Provider.of<SearchData>(context);
      List<RecipeItem> recipeItemList =  searchData.filter(recipeItems.recipeItemList);
    

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget> [
            IconButton(icon: Icon(Icons.search), onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },),
          ],
        ),
        body: Column(
          children: <Widget>[
            _showSearchBar ? Search(/* searchText*/) : Container(),
            Container(
              child: Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(6),
                  itemCount: recipeItemList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2),
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeListItem(recipeItemList[index]);
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
          tooltip: 'Lägg till nytt recept!',
          child: Icon(Icons.add,),
        ),
      );
    }
  }
}
