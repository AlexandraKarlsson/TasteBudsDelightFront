import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/widgets/recipe/view/ingredient_table.dart';
import 'package:tastebudsdelightfront/widgets/recipe/view/instruction_table.dart';
import '../../../data/recipe.dart';

class RecipeCookingMode extends StatelessWidget {
  final Recipe recipe;

  RecipeCookingMode(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tillagning av ${recipe.overview.title}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.timer,
              size: 35,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IngredientTable(recipe.ingredients),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InstructionTable(recipe.instructions),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
