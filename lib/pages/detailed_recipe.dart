import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/widgets/recipe/image_viewer.dart';
import 'package:tastebudsdelightfront/widgets/recipe/ingredient_table.dart';
import 'package:tastebudsdelightfront/widgets/recipe/instruction_table.dart';
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

  Widget _createChip(String name) {
    return Chip(
      avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade800, child: Icon(Icons.check)),
      backgroundColor: Colors.green,
      label: Text(name),
    );
  }

  List<Widget> _createChipList() {
    List<Widget> chipList = [];
    if (recipe.overview.isVegan) {
      chipList.add(_createChip('Vegansk'));
    }
    if (recipe.overview.isVegetarian) {
      chipList.add(_createChip('Vegitarisk'));
    }
    if (recipe.overview.isGlutenFree) {
      chipList.add(_createChip('Glutenfri'));
    }
    if (recipe.overview.isLactoseFree) {
      chipList.add(_createChip('Laktosfri'));
    }
    return chipList;
  }

  String _getAmountOfPortions() {
    String amount = '${recipe.overview.portions}';
    return recipe.overview.portions > 1
        ? '$amount portioner'
        : '$amount portion';
  }

  Table _getAllIngredientTableRows() {
    List<TableRow> tableRowList = [];
    recipe.ingredients.ingredientList.forEach((ingredient) {
      TableRow row = TableRow(children: <Widget>[
        TableCell(
            child: Align(
                alignment: Alignment.topRight,
                child: Text('${ingredient.amount.toInt()}'))),
        TableCell(child: Text(ingredient.unit)),
        TableCell(child: Text(ingredient.name)),
      ]);
      tableRowList.add(row);
    });
    Table table = Table(columnWidths: {
      0: FractionColumnWidth(.2),
      1: FractionColumnWidth(.2)
    }, children: <TableRow>[
      ...tableRowList,
    ]);
    return table;

    // List<Widget> ingredients = [];
    // recipe.ingredients.ingredientList.forEach((ingredient) {
    //   Widget ingredientText = Text('${ingredient.amount.toInt() } ${}  ${ingredient.name}');
    //   ingredients.add(ingredientText);
    // });
    // return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: Text(recipe.overview.title)),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ImageViewer(_getListOfImageNames()),
                        ..._createChipList(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.timer),
                                Text('${recipe.overview.time} min'),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.people),
                                Text(_getAmountOfPortions()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IngredientTable(recipe.ingredients),
                        SizedBox(
                          height: 10,
                        ),
                        InstructionTable(recipe.instructions),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
