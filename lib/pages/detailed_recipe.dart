import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/widgets/recipe/image_viewer.dart';
import 'dart:convert' as convert;

import '../data/recipe.dart';

class DetailedRecipe extends StatefulWidget {
  // static const PATH = '/detailed_recipe';

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
    final url = 'http://10.0.2.2:8000/tastebuds/recipe/${widget.id}';

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

  List<String> _getListOfImageNames() {
    List<String> imageNameList = [];
    recipe.images.imageList.forEach((image) {
      imageNameList.add(image.imageFileName);
    });
    return imageNameList;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: Text('')),
            body: Container(
              child: Column(children: <Widget>[
                ImageViewer(_getListOfImageNames()),
                Text(recipe.overview.title),
              ]),
            ),
          );
  }
}
