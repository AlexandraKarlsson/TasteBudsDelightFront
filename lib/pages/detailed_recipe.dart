import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';

import '../data/recipe.dart';
import '../widgets/recipe/view/recipe_detailed_view.dart';
import '../widgets/recipe/cooking/recipe_cooking_mode.dart';

class DetailedRecipe extends StatefulWidget {
  final id;
  DetailedRecipe(this.id);

  @override
  _DetailedRecipeState createState() => _DetailedRecipeState();
}

class _DetailedRecipeState extends State<DetailedRecipe> {
  bool _isLoading = false;
  Recipe recipe;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _fetchRecipe().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _fetchRecipe() async {
    print('_fetchRecipe(): Enter ...');
    SettingData setting = Provider.of<SettingData>(context, listen: false);

    final url = 'http://${setting.serverAddress}:8000/tastebuds/recipe/${widget.id}';

    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      Recipe recipe = Recipe.parse(responseData);
      print('recipe = $recipe');
      setState(() {
        this.recipe = recipe;
      });
    } else {
      print('_fetchRecipe(): status code = ${response.statusCode}!');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if(MediaQuery.of(context).orientation == Orientation.landscape) {
      page = RecipeCookingMode(recipe, widget.id);
    } else {
      page = RecipeDetailedView(recipe);
    }
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : page;

  }
}
