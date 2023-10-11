import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/Screen/bookmark_recipe/repository/bookmark_interface.dart';
import 'package:socialrecipe/screen/bookmark_recipe/widgets/bookmark_card.dart';
import 'package:socialrecipe/src/models/data_class_models/recipe_model.dart';
import 'package:provider/provider.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({Key? key}) : super(key: key);

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final bookmark = Provider.of<BookmarkInterface>(context, listen: false);
    return StreamBuilder<List<RecipeModel>>(
      stream: bookmark.watchAllRecipes(),
      builder: (context, snapshot) {
        final recipes = snapshot.data ?? [];
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          key: Key(recipes.length.toString()),
          separatorBuilder: (_, index) => const SizedBox(height: 32),
          itemBuilder: (context, index) {
            return BookmarkCard(
              recipe: recipes[index],
              deleteCallback: () {
                deleteRecipe(bookmark, recipes[index]);
              },
            );
          },
          itemCount: recipes.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
  void deleteRecipe(BookmarkInterface bookmark, RecipeModel recipe) {
    if (recipe.id != null) {
      bookmark.deleteRecipe(recipe);
      setState(() {});
    } else {
      debugPrint("recipe_ID_is_null".tr);
    }
  }
}
