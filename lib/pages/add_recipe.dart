import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:tastebudsdelightfront/data/images.dart';
import 'package:tastebudsdelightfront/data/ingredient.dart';
import 'package:tastebudsdelightfront/data/ingredients.dart';
import 'package:tastebudsdelightfront/data/overview.dart';
import 'package:tastebudsdelightfront/data/recipe.dart';
import 'package:tastebudsdelightfront/data/recipes.dart';
import 'package:tastebudsdelightfront/data/instructions.dart';

import '../widgets/recipe/images_tab.dart';
import '../widgets/recipe/instruction_tab.dart';
import '../widgets/recipe/ingredients_tab.dart';
import '../widgets/recipe/overview_tab.dart';

class AddRecipe extends StatefulWidget {
  static const PATH = '/add_recipe';

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
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

    const url = 'http://10.0.2.2:8000/tastebuds/recipe';
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

    final String url = 'http://10.0.2.2:8010/image';
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
    // Post recipe to backend and recive list of imagenames and recipeid.
    final recipeResponse = await _saveRecipeData();
    if(recipeResponse != null) {
        // Post image/s to imagestorage.
      _uploadImages(recipeResponse['imageFileNames']);
      // Clear all provider objects used for adding a recipe.
    _clearProviderData();
    Navigator.pop(context);
    } else {
      print('Save recipe failed!');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skapa recept'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: _saveRecipe)
        ],
      ),
      body: Container(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text('Översikt'),
              icon: Icon(Icons.border_color),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text('Ingredienser'),
              icon: Icon(Icons.add_shopping_cart),
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
