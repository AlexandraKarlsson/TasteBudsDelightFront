class RecipeItem {
  final int id;
  final String imageFileName;
  final String title;
  final String description;
  final int time;
  final int portions;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;

  RecipeItem(
    this.id,
    this.imageFileName,
    this.title,
    this.description,
    this.time,
    this.portions,
    this.isVegan,
    this.isVegetarian,
    this.isGlutenFree,
    this.isLactoseFree,
  );
}
