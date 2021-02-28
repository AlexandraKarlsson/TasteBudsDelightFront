import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/recipe_items.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';

import '../../animation_failure.dart';
import '../../animation_success.dart';
import 'ingredient_table.dart';
import 'instruction_table.dart';
import '../../../data/recipe.dart';
import '../../../widgets/image_viewer.dart';

enum AddingState { normal, busy, successful, failure }

class RecipeDetailedView extends StatefulWidget {
  final Recipe recipe;
  final userId;
  final recipeId;

  RecipeDetailedView(this.recipe, this.userId, this.recipeId);

  @override
  _RecipeDetailedViewState createState() => _RecipeDetailedViewState();
}

class _RecipeDetailedViewState extends State<RecipeDetailedView> {
  AddingState state = AddingState.normal;
  String successfulText = "";
  String failureText = "";

  List<String> _getListOfImageNames() {
    List<String> imageNameList = [];
    widget.recipe.images.imageList.forEach((image) {
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
    if (widget.recipe.overview.isVegan) {
      chipList.add(_createChip('Vegansk'));
    }
    if (widget.recipe.overview.isVegetarian) {
      chipList.add(_createChip('Vegitarisk'));
    }
    if (widget.recipe.overview.isGlutenFree) {
      chipList.add(_createChip('Glutenfri'));
    }
    if (widget.recipe.overview.isLactoseFree) {
      chipList.add(_createChip('Laktosfri'));
    }
    return chipList;
  }

  String _getAmountOfPortions() {
    String amount = '${widget.recipe.overview.portions}';
    return widget.recipe.overview.portions > 1
        ? '$amount portioner'
        : '$amount portion';
  }

  Future<void> deleteRecipe(context, userData) async {
    setState(() {
      state = AddingState.busy;
    });

    SettingData setting = Provider.of<SettingData>(context, listen: false);

    String url =
        'http://${setting.backendAddress}:${setting.backendPort}/tastebuds/recipe/${widget.recipeId}';
    final headers = <String, String>{
      'x-auth': userData.token,
    };

    try {
      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        RecipeItems recipeItems = Provider.of<RecipeItems>(context, listen:false);
        recipeItems.deleteRecipe(widget.recipeId);
        setState(() {
          state = AddingState.successful;
          successfulText = "Receptet borttaget.";
        });
      }
      if (response.statusCode == 400) {
        setState(() {
          state = AddingState.failure;
          failureText =
              "Det gick inte att ta bort receptet, var vänlig försök igen!";
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        state = AddingState.failure;
        failureText = "Något oväntat hände, var vänlig försök igen senare!";
      });
    }
  }

  setNormalState() {
    setState(() {
      state = AddingState.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context, listen: false);

    if (state == AddingState.busy) {
      return Center(child: CircularProgressIndicator());
    } else if (state == AddingState.successful) {
      return AnimationSuccess(successfulText);
    } else if (state == AddingState.failure) {
      return AnimationFailure(failureText, setNormalState);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.overview.title),
          actions: [
            userData.token != null && userData.id == widget.userId
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteRecipe(context, userData);
                    },
                  )
                : Container(),
          ],
        ),
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
                      child: ReadMoreText(widget.recipe.overview.description),
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
                                  Text('${widget.recipe.overview.time} min'),
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
                          IngredientTable(widget.recipe.ingredients),
                          SizedBox(
                            height: 10,
                          ),
                          InstructionTable(widget.recipe.instructions),
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
}
