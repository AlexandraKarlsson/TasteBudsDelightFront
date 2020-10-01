

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
}