import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/cooking/cooking_ingredients.dart';
import '../../../data/cooking/cooking_instructions.dart';
import '../../../data/cooking/cooking_recipe.dart';
import '../../../data/recipe.dart';

import 'cooking_ingredient_table.dart';
import 'cooking_instruction_table.dart';

class RecipeCookingMode extends StatelessWidget {
  final Recipe recipe;
  final int id;

  RecipeCookingMode(this.recipe, this.id);

  @override
  Widget build(BuildContext context) {
    CookingRecipe cookingRecipe = Provider.of<CookingRecipe>(context);
    if (cookingRecipe.isNewId(id)) { 
      //Ask user not clear or not
      cookingRecipe.newRecipe(id);
      CookingIngredients cookingIngrediets =
          Provider.of<CookingIngredients>(context);
      cookingIngrediets.add(recipe.ingredients);
      CookingInstructions cookingInstructions =
          Provider.of<CookingInstructions>(context);
      cookingInstructions.add(recipe.instructions);
    }

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
                      child: CookingIngredientTable(recipe.ingredients),
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
                      child: CookingInstructionTable(recipe.instructions),
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
