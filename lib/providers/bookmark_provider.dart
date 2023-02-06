import 'dart:async';
import 'package:socialrecipe/screen/bookmark_recipe/repository/bookmark_interface.dart';
import 'package:socialrecipe/src/models/data_class_models/recipe_model.dart';

class BookmarkProvider extends BookmarkInterface {
  final List<RecipeModel> _currentRecipes = [];

  Stream<List<RecipeModel>>? _recipeStream;

  final StreamController _recipeStreamController =
      StreamController<List<RecipeModel>>();

  @override
  Stream<List<RecipeModel>> watchAllRecipes() {
    _recipeStream ??=
        _recipeStreamController.stream as Stream<List<RecipeModel>>;
    return _recipeStream!;
  }

  // Data modification methods:
  @override
  Future<void> insertRecipe(RecipeModel recipe) async {
    if (!_currentRecipes.contains(recipe)) {
      _currentRecipes.add(recipe);
      _recipeStreamController.sink.add(_currentRecipes);
    }
  }

  @override
  Future<void> deleteRecipe(RecipeModel recipe) {
    _currentRecipes.remove(recipe);
    return Future.value();
  }

  //
  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
  }
}
