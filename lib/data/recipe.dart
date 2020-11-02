import 'images.dart';
import 'steps.dart';
import 'ingredients.dart';
import 'overview.dart';

class Recipe {
  Overview overview;
  Ingredients ingredients;
  Steps steps;
  Images images;

  Recipe(this.overview,this.ingredients,this.steps, this.images);

  factory Recipe.parse(Map<String,dynamic> recipeData) {
    // Not implmeented yet ...
    
    final overviewData = recipeData['overview'];
    Overview overview = Overview();
    overview.setTitle(overviewData['title']);
    overview.setDescription(overviewData['description']);
    overview.setTime(overviewData['time']);
    overview.setPortions(overviewData['portions']);
    overview.setIsVegan(overviewData['isvegan'] == 0 ? false : true);
    overview.setIsVegetarian(overviewData['isvegetarian'] == 0 ? false : true);
    overview.setIsGlutenFree(overviewData['isglutenfree'] == 0 ? false : true);
    overview.setIsLactoseFree(overviewData['islactosefree'] == 0 ? false : true);


    Ingredients ingredients = Ingredients();
    recipeData['ingredients'].forEach((ingredient) {
      ingredients.add(ingredient['amount'].toDouble() , ingredient['unit'], ingredient['name']);
    });

    Steps instructions = Steps();
    recipeData['instructions'].forEach((instruction) {
      instructions.add(instruction['ordernumber'], instruction['description']);
    });

    Images images = Images.parse(recipeData['images']);

    return Recipe(overview,ingredients,instructions,images);
  }
}