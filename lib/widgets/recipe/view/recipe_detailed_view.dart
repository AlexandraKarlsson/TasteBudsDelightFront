import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';

import 'ingredient_table.dart';
import 'instruction_table.dart';
import '../../../data/recipe.dart';
import '../../../widgets/image_viewer.dart';

class RecipeDetailedView extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailedView(this.recipe);

    List<String> _getListOfImageNames() {
    List<String> imageNameList = [];
    recipe.images.imageList.forEach((image) {
      imageNameList.add(image.imageFileName);
    });
    return imageNameList;
  }

  Widget _createChip(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Chip(
        avatar: CircleAvatar(
            backgroundColor: Colors.black, child: Icon(Icons.check)),
        backgroundColor: Colors.red[400],
        label: Text(name),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text(recipe.overview.title)),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ImageViewer(_getListOfImageNames()),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          child: ReadMoreText(recipe.overview.description),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[..._createChipList()],
                              ),
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
                            ],
                          ),
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