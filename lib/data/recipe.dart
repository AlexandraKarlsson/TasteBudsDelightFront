import 'images.dart';
import 'instructions.dart';
import 'ingredients.dart';
import 'overview.dart';

class Recipe {
  Overview overview;
  Ingredients ingredients;
  Instructions instructions;
  Images images;

  Recipe(this.overview, this.ingredients, this.instructions, this.images);

  factory Recipe.parse(Map<String, dynamic> recipeData) {
    final overviewData = recipeData['overview'];
    Overview overview = Overview();
    // TODO: Parse id
    overview.setTitle(overviewData['title']);
    overview.setDescription(overviewData['description']);
    overview.setTime(overviewData['time']);
    overview.setPortions(overviewData['portions']);
    overview.setIsVegan(overviewData['isvegan'] == 0 ? false : true);
    overview.setIsVegetarian(overviewData['isvegetarian'] == 0 ? false : true);
    overview.setIsGlutenFree(overviewData['isglutenfree'] == 0 ? false : true);
    overview
        .setIsLactoseFree(overviewData['islactosefree'] == 0 ? false : true);

    Ingredients ingredients = Ingredients();
    recipeData['ingredients'].forEach((ingredient) {
      ingredients.add(ingredient['amount'].toDouble(), ingredient['unit'],
          ingredient['name']);
    });

    Instructions instructions = Instructions();
    recipeData['instructions'].forEach((instruction) {
      instructions.add(instruction['description']);
    });

    Images images = Images.parse(recipeData['images']);

    return Recipe(overview, ingredients, instructions, images);
  }

  void updateProvidersForEdit(int recipeId, Overview editOverview, Ingredients editIngredients,
      Instructions editInstructions, Images editImages) {
        editOverview.clear();
        editIngredients.clear();
        editInstructions.clear();
        editImages.clear();

        editOverview.recipeId = recipeId;
        editOverview.title = overview.title;
        editOverview.description = overview.description;
        editOverview.time = overview.time;
        editOverview.portions = overview.portions;
        editOverview.isVegan = overview.isVegan;
        editOverview.isVegetarian = overview.isVegetarian;
        editOverview.isGlutenFree = overview.isGlutenFree;
        editOverview.isLactoseFree = overview.isLactoseFree;
        
        ingredients.ingredientList.forEach((ingredient) {
          editIngredients.add(ingredient.amount, ingredient.unit, ingredient.name);
        });

        instructions.instructionList.forEach((instruction) {
          editInstructions.add(instruction.description);
        });

        images.imageList.forEach((image) {
          editImages.addImage(image);
         });

      }
}
