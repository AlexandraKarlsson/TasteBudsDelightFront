import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tastebudsdelightfront/communication/backend.dart';
import 'package:tastebudsdelightfront/communication/common.dart';
import 'package:tastebudsdelightfront/data/images.dart';
import 'package:tastebudsdelightfront/data/ingredients.dart';
import 'package:tastebudsdelightfront/data/instructions.dart';
import 'package:tastebudsdelightfront/data/overview.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'dart:convert' as convert;

import 'account_login.dart';
import 'account_profile.dart';
import 'add_edit_recipe.dart';
import '../data/recipe_item.dart';
import '../data/search_data.dart';
import '../data/recipe_items.dart';
import '../pages/settings_page.dart';
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

  static const int LOGIN = 1;
  static const int PROFILE = 2;
  static const int LOGOUT = 3;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      print('Set _isLoading = true');
      setState(() {
        _isLoading = true;
      });
    }
    _fetchRecipes().then((_) {
      print('Set _isLoading = false');
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> _fetchRecipes() async {
    print('running _fetchRecipe');

    final ResponseReturned response = await fetchRecipes(context);

    if (response.state == ResponseState.successful) {
      final responseData =
          convert.jsonDecode(response.response.body) as Map<String, dynamic>;
      RecipeItems recipeItems =
          Provider.of<RecipeItems>(context, listen: false);
      recipeItems.parseAndAdd(responseData);
    }
    // ResponseState failure and error don't need any actions.
  }

  Future<void> _logout() async {
    print('running _logout');

    UserData userData = Provider.of<UserData>(context, listen: false);

    final ResponseReturned response = await logout(context, userData.token);
    if (response.state == ResponseState.successful) {
      userData.clear();
      print('User logged out');
    }
    // Decision: When failure/error do not show message to user.
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      UserData userData = Provider.of<UserData>(context);
      RecipeItems recipeItems = Provider.of<RecipeItems>(context);
      SearchData searchData = Provider.of<SearchData>(context);
      List<RecipeItem> recipeItemList =
          searchData.filter(recipeItems.recipeItemList, userData.id);

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.grey[700],
              ),
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.PATH);
              },
            ),
            PopupMenuButton<int>(
              offset: const Offset(0, 30),
              icon: Hero(
                tag: 'account',
                child: userData.token == null
                    ? Icon(Icons.account_circle, color: Colors.white)
                    : Icon(
                        Icons.account_circle_outlined,
                        color: Colors.greenAccent,
                      ),
              ),
              itemBuilder: (context) => [
                userData.token == null
                    ? PopupMenuItem(
                        height: 12,
                        value: LOGIN,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Logga in"),
                          ],
                        ),
                      )
                    : null,
                userData.token != null
                    ? PopupMenuItem(
                        height: 15,
                        value: PROFILE,
                        child: Row(
                          children: [
                            Icon(
                              Icons.manage_accounts,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Profil", style: TextStyle(fontSize: 17))
                          ],
                        ),
                      )
                    : null,
                userData.token != null
                    ? PopupMenuDivider(
                        height: 10,
                      )
                    : null,
                userData.token != null
                    ? PopupMenuItem(
                        height: 15,
                        value: LOGOUT,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Logga ut", style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      )
                    : null,
              ],
              onSelected: (value) => {
                print('Value = $value'),
                if (value == LOGIN)
                  {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 2),
                        pageBuilder: (_, __, ___) => AccountLogin(),
                      ),
                    )
                  }
                else if (value == PROFILE)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountProfile()),
                    ),
                  }
                else if (value == LOGOUT)
                  {_logout()}
                else
                  {print('Unknown selection = $value')}
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _fetchRecipes,
          child: Container(
            child: Column(
              children: <Widget>[
                _showSearchBar ? Search() : Container(),
                Flexible(
                  child: GridView.builder(
                    padding: EdgeInsets.all(6),
                    itemCount: recipeItemList.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 3
                            : 2),
                    itemBuilder: (BuildContext context, int index) {
                      return RecipeListItem(recipeItemList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: userData.token != null ? true : false,
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<Overview>(context, listen: false).clear();
              Provider.of<Ingredients>(context, listen: false).clear();
              Provider.of<Instructions>(context, listen: false).clear();
              Provider.of<Images>(context, listen: false).clear();
              Navigator.pushNamed(context, AddEditRecipe.PATH);
            },
            tooltip: 'Lägg till nytt recept!',
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      );
    }
  }
}
