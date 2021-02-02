import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../data/setting_data.dart';
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

class AddRecipe extends StatefulWidget {
  static const PATH = '/add_recipe';

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  int _selectedIndex = 0;
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

  Future<Map<String, dynamic>> _saveRecipeData() async {
    // Create post-data structure
    Overview overview = Provider.of<Overview>(context, listen: false);
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: false);
    Instructions steps = Provider.of<Instructions>(context, listen: false);
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
      "steps": steps.listOfDescriptions(),
      "images": images.listOfExtentions(),
    };
    // print('newRecipeData: $newRecipeData.');

    SettingData setting = Provider.of<SettingData>(context, listen: false);

    String url =
        'http://${setting.backendAddress}:${setting.backendPort}/tastebuds/recipe';
    const headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };

    var newRecipeDataJson = convert.jsonEncode(newRecipeData);
    // print('newRecipeDataJson = $newRecipeDataJson');

    final response = await http.post(
      url,
      headers: headers,
      body: newRecipeDataJson,
    );
    if (response.statusCode == 201) {
      print('response ${response.body}');
      var responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('responseData = $responseData');
      return responseData;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<void> _uploadImages(List<dynamic> imageNames) async {
    Images images = Provider.of<Images>(context, listen: false);
    SettingData setting = Provider.of<SettingData>(context, listen: false);

    final String url =
        'http://${setting.imageAddress}:${setting.imagePort}/image';
    for (int i = 0; i < images.imageList.length; i++) {
      File file = images.imageList[i].file;
      String fileName = imageNames[i];
      String base64Image = convert.base64Encode(file.readAsBytesSync());
      //var headers = <String, String>{'x-auth': user.token};

      http.post(
        url,
        //headers: headers,
        body: {
          "image": base64Image,
          "name": fileName,
        },
      ).then((response) {
        print(response.statusCode);
        print('fileName = $fileName');
      }).catchError((error) {
        print('Upload image failed');
        print(error);
      });
    }
  }

  void _saveRecipe() async {
    setState(() {
      state = AddingState.saving;
    });
    // Post recipe to backend and recive list of imagenames and recipeid.
    final recipeResponse = await _saveRecipeData();
    if (recipeResponse != null) {
      // Post image/s to imagestorage.
      _uploadImages(recipeResponse['imageFileNames']);
      // Clear all provider objects used for adding a recipe.
      _clearProviderData();
      setState(() {
        state = AddingState.successful;
      });
    } else {
      print('Save recipe failed!');
      setState(() {
        state = AddingState.failure;
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
    if (state == AddingState.saving) {
      return Center(child: CircularProgressIndicator());
    } else if (state == AddingState.successful) {
      return AnimationSuccess('Receptet skapades!');
    } else if (state == AddingState.failure) {
      return AnimationFailure('Receptet gick inte att spara!', setNormalState);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Skapa recept'),
        ),
        body: Container(
          child: Column(
            children: [
              checkMinimalCriteria(context) ?
              Expanded(
                flex: 1,
                child: InkWell(child: AnimationSave(), onTap: _saveRecipe),
              ) : Container(),
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
