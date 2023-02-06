import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:socialrecipe/src/models/recipe_post_model.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/ingredients_post_section.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/post_detail_sliver_app_bar.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/post_details_title_section.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/serve_and_cook_time_section.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/steps_post_section.dart';

// ignore: must_be_immutable
class RecipePostDetailScreen extends StatefulWidget {
  RecipePostDetailScreen({
    Key? key,
    required this.recipePost,
  }) : super(key: key);
  RecipePostModel recipePost;
  @override
  State<RecipePostDetailScreen> createState() => _RecipePostDetailScreenState();
}

class _RecipePostDetailScreenState extends State<RecipePostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                PostDetailSliverAppBar(
                  postImageUrl: widget.recipePost.postUrl,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostDetailTitleSection(
                            recipePost: widget.recipePost,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 2.0,
                            dashLength: 12.0,
                            dashColor: Colors.black,
                            dashGradient: const [
                              Color.fromARGB(255, 244, 70, 54),
                              Color.fromARGB(255, 10, 92, 88)
                            ],
                            dashRadius: 5.0,
                            dashGapLength: 3.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 2.0,
                          ),
                          ServeAndCookTimeSection(
                            cookTime: widget.recipePost.cookTime,
                            serveAmount: widget.recipePost.serveAmount,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 2.0,
                            dashLength: 12.0,
                            dashColor: Colors.black,
                            dashGradient: const [
                              Color.fromARGB(255, 244, 70, 54),
                              Color.fromARGB(255, 10, 92, 88)
                            ],
                            dashRadius: 5.0,
                            dashGapLength: 3.0,
                            dashGapColor: Colors.transparent,
                            //dashGapGradient: [Colors.red, Colors.blue],
                            dashGapRadius: 2.0,
                          ),
                          const SizedBox(height: 16),
                          IngredientsPostSection(
                            ingredients: widget.recipePost.ingredients,
                          ),
                          const SizedBox(height: 16),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 2.0,
                            dashLength: 12.0,
                            dashColor: Colors.black,
                            dashGradient: const [
                              Color.fromARGB(255, 244, 70, 54),
                              Color.fromARGB(255, 10, 92, 88)
                            ],
                            dashRadius: 5.0,
                            dashGapLength: 3.0,
                            dashGapColor: Colors.transparent,
                            //dashGapGradient: [Colors.red, Colors.blue],
                            dashGapRadius: 2.0,
                          ),
                          const SizedBox(height: 16),
                          StepsPostSection(
                            steps: widget.recipePost.instructions,
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
