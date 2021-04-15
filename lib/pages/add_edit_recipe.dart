import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/communication/backend.dart';
import 'package:tastebudsdelightfront/communication/common.dart';
import 'package:tastebudsdelightfront/communication/imagestore.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';

import '../data/images.dart';
import '../data/ingredients.dart';
import '../data/overview.dart';
import '../data/instructions.dart';
import '../widgets/animation_success.dart';
import '../widgets/animation_failure.dart';
import '../widgets/recipe/create/animation_save.dart';
import '../widgets/recipe/create/check_minimal_criteria.dart';
import '../widgets/recipe/create/images_tab.dart';
import '../widgets/recipe/create/instruction_tab.dart';
import '../widgets/recipe/create/ingredients_tab.dart';
import '../widgets/recipe/create/overview_tab.dart';

enum AddingState { normal, saving, successful, failure }

class AddEditRecipe extends StatefulWidget {
  static const PATH = '/add_edit_recipe';

  @override
  _AddEditRecipeState createState() => _AddEditRecipeState();
}

class _AddEditRecipeState extends State<AddEditRecipe> {
  int _selectedIndex = 0;
  String successText = "";
  String failureText = "";
  AddingState state = AddingState.normal;

  static List<Widget> _widgetOptions = [
    OverviewTab(),
    IngredientsTab(),
    InstructionTab(),
    ImagesTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//====================================================
// SAVE NEW RECIPE
//====================================================

  Future<Map<String, dynamic>> _createRecipe() async {
    // Create post-data structure
    UserData userData = Provider.of<UserData>(context, listen: false);
    Overview overview = Provider.of<Overview>(context, listen: false);
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    Instructions instructions =
        Provider.of<Instructions>(context, listen: false);
    Images images = Provider.of<Images>(context, listen: false);

    final newRecipeData = {
      "overview": {
        "title": overview.title,
        "description": overview.description,
        "time": overview.time,
        "portions": overview.portions,
        "isvegan": overview.isVegan,
        "isvegetarian": overview.isVegetarian,
        "isglutenfree": overview.isGlutenFree,
        "islactosefree": overview.isLactoseFree
      },
      "ingredients": ingredients.listOfIngredients(),
      "steps": instructions.listOfDescriptions(),
      "images": images.listOfExtentions(),
    };
    // print('newRecipeData: $newRecipeData.');

    var newRecipeDataJson = convert.jsonEncode(newRecipeData);
    // print('newRecipeDataJson = $newRecipeDataJson');

    final ResponseReturned response =
        await createRecipe(context, newRecipeDataJson, userData.token);

    if (response.state == ResponseState.successful) {
      var responseData =
          convert.jsonDecode(response.response.body) as Map<String, dynamic>;
      print('responseData = $responseData');
      return responseData;
    } else {
      // ResponseState failure and error.
      return null;
    }
  }

  Future<void> _uploadImages(List<dynamic> imageNames) async {
    Images images = Provider.of<Images>(context, listen: false);

    for (int i = 0; i < imageNames.length; i++) {
      images.imageList[i].imageFileName = imageNames[i];
      await uploadImage(context, images.imageList[i]);
    }
  }

  void _saveRecipe() async {
    setState(() {
      state = AddingState.saving;
    });
    final recipeResponse = await _createRecipe();
    if (recipeResponse != null) {
      await _uploadImages(recipeResponse['imageFileNames']);

      _clearProviderData();
      setState(() {
        state = AddingState.successful;
        successText = "Receptet sparat!";
      });
    } else {
      print('Save recipe failed!');
      setState(() {
        state = AddingState.failure;
        failureText = "Receptet gick inte att spara!";
      });
    }
  }

//====================================================
// UPDATE OLD RECIPE
//====================================================

  Future<Map<String, dynamic>> _updateRecipeData() async {
    // Create post-data structure
    UserData userData = Provider.of<UserData>(context, listen: false);
    Overview overview = Provider.of<Overview>(context, listen: false);
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    Instructions instructions =
        Provider.of<Instructions>(context, listen: false);
    Images images = Provider.of<Images>(context, listen: false);

    final updateRecipeData = {
      "id": overview.recipeId,
      "overview": {
        "title": overview.title,
        "description": overview.description,
        "time": overview.time,
        "portions": overview.portions,
        "isvegan": overview.isVegan,
        "isvegetarian": overview.isVegetarian,
        "isglutenfree": overview.isGlutenFree,
        "islactosefree": overview.isLactoseFree
      },
      "ingredients": ingredients.listOfIngredients(),
      "steps": instructions.listOfDescriptions(),
      "images": images.createBackendData(),
    };
    print('updateRecipeData = $updateRecipeData');

    var updateRecipeDataJson = convert.jsonEncode(updateRecipeData);
    print('updateRecipeDataJson = $updateRecipeDataJson');

    final ResponseReturned response =
        await updateRecipe(context, updateRecipeDataJson, userData.token);

    if (response.state == ResponseState.successful) {
      var responseData =
          convert.jsonDecode(response.response.body) as Map<String, dynamic>;
      print('responseData = $responseData');
      return responseData;
    } else {
      // ResponseState failure and error.
      return null;
    }
  }

  Future<void> _updateImages(List<dynamic> imageNames) async {
    Images images = Provider.of<Images>(context, listen: false);
    final imageList = images.imageList;

    int newNameIndex = 0;
    // Add the images
    for (int i = 0; i < imageList.length; i++) {
      if (imageList[i].file != null) {
        imageList[i].imageFileName = imageNames[newNameIndex];
        newNameIndex += 1;
        bool answer = await uploadImage(context, imageList[i]);
        if (!answer) {
          print('Failed to upload image = ${imageList[i].imageFileName}');
        }
      }
    }

    // Delete the images
    final deletedImageList = images.deletedImageList;
    for (int i = 0; i < deletedImageList.length; i++) {
      if (deletedImageList[i].imageFileName != null) {
        bool answer =
            await deleteImage(context, deletedImageList[i].imageFileName);
        if (!answer) {
          print(
              'Failed to delete image = ${deletedImageList[i].imageFileName}');
        }
      }
    }
  }

  void _updateRecipe() async {
    setState(() {
      state = AddingState.saving;
    });

    final recipeResponse = await _updateRecipeData();
    if (recipeResponse != null) {
      await _updateImages(recipeResponse['imageFileNames']);

      _clearProviderData();
      print('Update recipe succeeded!');
      setState(() {
        state = AddingState.successful;
        successText = "Receptet uppdaterad!";
      });
    } else {
      print('Update recipe failed!');
      setState(() {
        state = AddingState.failure;
        failureText = "Receptet gick inte att uppdatera!";
      });
    }
  }

  _clearProviderData() {
    Overview overview = Provider.of<Overview>(context, listen: false);
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    Instructions steps = Provider.of<Instructions>(context, listen: false);
    Images images = Provider.of<Images>(context, listen: false);

    overview.clear();
    ingredients.clear();
    steps.clear();
    images.clear();
  }

  setNormalState() {
    setState(() {
      state = AddingState.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    Overview overview = Provider.of<Overview>(context, listen: false);
    if (state == AddingState.saving) {
      return Center(child: CircularProgressIndicator());
    } else if (state == AddingState.successful) {
      return AnimationSuccess(successText);
    } else if (state == AddingState.failure) {
      return AnimationFailure(failureText, setNormalState);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Skapa recept'),
        ),
        body: Container(
          child: Column(
            children: [
              checkMinimalCriteria(context)
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                          child: AnimationSave(),
                          onTap: overview.recipeId == -1
                              ? _saveRecipe
                              : _updateRecipe),
                    )
                  : Container(),
              Expanded(
                flex: 8,
                child: _widgetOptions[_selectedIndex],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[400],
          items: [
            BottomNavigationBarItem(
                title: Text('Översikt'),
                icon: Icon(Icons.border_color),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                title: Text('Ingredienser'),
                icon: Icon(Icons.fastfood),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                title: Text('Beskrivnig'),
                icon: Icon(Icons.format_list_bulleted),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                title: Text('Bild'),
                icon: Icon(Icons.add_photo_alternate),
                backgroundColor: Colors.black),
          ],
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
