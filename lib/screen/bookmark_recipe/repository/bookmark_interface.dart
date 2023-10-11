import 'package:aharconnect/src/models/data_class_models/recipe_model.dart';

abstract class BookmarkInterface {
  Future<void> insertRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(RecipeModel recipe);

  Stream<List<RecipeModel>> watchAllRecipes();

  Future init();
  void close();
}
