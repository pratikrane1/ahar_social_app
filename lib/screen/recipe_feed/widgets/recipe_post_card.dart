import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/providers/dynamic_link.dart';
import 'package:aharconnect/screen/group/widget/group_feed_widget.dart';
import 'package:aharconnect/utils/app_pages.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:aharconnect/src/models/recipe_post_model.dart';
import 'package:aharconnect/src/models/user_model.dart';
import 'package:aharconnect/providers/recipe_post_provider.dart';
import 'package:aharconnect/screen/recipe_feed/widgets/animated_like_button.dart';
import 'package:aharconnect/screen/search_recipe/widgets/custom_drop_down.dart';
import 'package:aharconnect/providers/settings_provider.dart';
import 'package:aharconnect/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:aharconnect/utils/theme_colors.dart';

class RecipePostCard extends StatefulWidget {
  const RecipePostCard({
    Key? key,
    this.feedData,
    // required this.feedData,
  }) : super(key: key);
  final FeedModel? feedData;

  @override
  State<RecipePostCard> createState() => _RecipePostCardState();
}

class _RecipePostCardState extends State<RecipePostCard> {
  List<String> popUpMenuItems = ['Delete'];
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      // decoration: BoxDecoration(
      //     // borderRadius: const BorderRadius.all(Radius.circular(10)),
      //     color: settingsManager.darkMode ? kGreyColor7 : kGreyColor7,
      //     border: Border.all(
      //       color:
      //           settingsManager.darkMode ? kBlackColor : Colors.grey.shade400,
      //       width: 1,
      //     )),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User image and user name section.
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth - (screenWidth - 15),
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: widget.feedData!.userImage.toString(),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                            const Center(
                              child: Icon(
                                  Icons
                                      .circle),
                            ),
                            placeholder: (context, url) =>
                                Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor:
                                    Colors.grey.shade300,
                                    child: SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height /
                                            3.3,
                                        width: double.infinity)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              //username
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   mainAxisSize: MainAxisSize.min,
                              //
                              //   children: [
                              //
                              //   ],
                              // ),
                              GestureDetector(
                                onTap: () {
                                  // if (currentUser!.uid != widget.post.uid) {
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     AppPages.profilePath,
                                  //     arguments: widget.post.uid,
                                  //   );
                                  // }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text(
                                      widget.feedData!.userName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 4,),
                                    Expanded(
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        // width: MediaQuery.of(context).size.width*0.4,
                                        child: Text(
                                          widget.feedData!.zoneName ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                              color: ThemeColors.greyTextColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),
                              //Post Image
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   AppPages.recipePostDetails,
                                  //   arguments: widget.post,
                                  // );
                                },
                                child: Material(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(20),
                                  shadowColor: Colors.grey.withOpacity(0.1),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: screenHeight / 4.2,
                                        width: screenWidth / 1.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.feedData!.postImage ?? "",
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) =>
                                            const Center(
                                              child: Icon(
                                                  Icons
                                                      .circle),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade400,
                                                  highlightColor: Colors.grey.shade300,
                                                  child: SizedBox(
                                                      height:
                                                      MediaQuery.of(context).size.height /
                                                          3.3,
                                                      width: double.infinity),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              //Post Title
                              Text(
                                widget.feedData!.postText ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: Theme.of(context).textTheme.headline3!.copyWith(
                                  height: 1.5,
                                ),
                              ),
                              //Like && Comment & Share Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //!: Like button:
                                  AnimatedLikeButton(
                                    isAnimating: true == null
                                        ? false
                                        : true,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          splashRadius: 20,
                                          onPressed: () async {
                                            // await postProvider.likeOrUnlikePost(
                                            //   postId: widget.post.postId,
                                            //   userId: user!.id,
                                            //   likes: widget.post.likes,
                                            // );
                                          },
                                          icon: Icon(
                                            Icons.thumb_up_alt_rounded,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        1 > 0 ?
                                    Text(
                                      '${0}',
                                      maxLines: 1,
                                    ): Container(),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: 30,),
                                  // Comment Button
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   AppPages.commentsPath,
                                      //   arguments: widget.post,
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.comment,
                                      color: ThemeColors.greyIconColor,
                                    ),
                                  ),
                                  // SizedBox(width: 30,),

                                  //Share Button
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      // DynamicLinkService().shareProductLink(
                                      //     title: "${widget.feedData!.zoneName}",
                                      //     url: Uri.parse('https://aharsocialapp.in/post?id=${widget.post.postId}'),
                                      //     // url: Uri.parse('https://aharsocialapp.in/post?id=1'),
                                      //     image: '${widget.post.postUrl}');
                                    },
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: ThemeColors.greyIconColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // !: PopUpMenu
                  currentUser?.uid != 1
                      ? const SizedBox()
                      : PopupMenuButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.more_vert,
                            size: 18,
                            color: Colors.grey.shade300,
                          ),
                          onSelected: (String value) {
                            // if (value == 'Delete') {
                            //   Provider.of<RecipePostProvider>(context,
                            //           listen: false)
                            //       .deletePost(widget.post.postId);
                            // }
                          },
                          itemBuilder: (BuildContext context) {
                            return popUpMenuItems
                                .map<CustomDropDownMenu<String>>(
                                  (String value) => CustomDropDownMenu(
                                    value: value,
                                    text: value,
                                    isRemovable: false,
                                    callback: () {
                                      setState(
                                        () {
                                          FocusScope.of(context).unfocus();
                                          popUpMenuItems.remove(value);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                )
                                .toList();
                          },
                        ),
                ],
              ),
            ),
            const Divider(thickness: 0.8,)
            //The post description.
            // Padding(
            //   padding: const EdgeInsets.only(
            //     right: 15,
            //     left: 70,
            //     bottom: 12,
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child:
            //       ),
            //     ],
            //   ),
            // ),
            //Image container or card.
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     // Likes and other interactions:
            //     const SizedBox(height: 8),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         right: 15,
            //         left: 15,
            //         bottom: 8,
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Row(
            //             children: [
            //               Expanded(
            //                 child: widget.post.likes.length == 1
            //                     ? Text(
            //                         '${widget.post.likes.length.toString()} Like',
            //                         maxLines: 1,
            //                       )
            //                     : Text(
            //                         '${widget.post.likes.length.toString()} Likes',
            //                         maxLines: 1,
            //                       ),
            //               ),
            //             ],
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 14.0)
            //                 .copyWith(bottom: 8),
            //             // child: Row(
            //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             //   children: [
            //             //     //!: Like button:
            //             //     AnimatedLikeButton(
            //             //       isAnimating: user == null
            //             //           ? false
            //             //           : widget.post.likes.contains(user.id),
            //             //       child: IconButton(
            //             //         splashRadius: 20,
            //             //         onPressed: () async {
            //             //           await postProvider.likeOrUnlikePost(
            //             //             postId: widget.post.postId,
            //             //             userId: user!.id,
            //             //             likes: widget.post.likes,
            //             //           );
            //             //         },
            //             //         icon: user == null
            //             //             ? Icon(
            //             //                 FontAwesomeIcons.solidThumbsUp,
            //             //                 color: Colors.grey.shade300,
            //             //               )
            //             //             : widget.post.likes.contains(user.id)
            //             //                 ? const Icon(
            //             //                     FontAwesomeIcons.solidThumbsUp,
            //             //                     color:
            //             //                         Color.fromARGB(255, 20, 79, 64),
            //             //                   )
            //             //                 : Icon(
            //             //                     FontAwesomeIcons.thumbsUp,
            //             //                     color: settingsManager.darkMode
            //             //                         ? Colors.grey.shade300
            //             //                         : Colors.grey.shade800,
            //             //                   ),
            //             //       ),
            //             //     ),
            //             //     IconButton(
            //             //       splashRadius: 20,
            //             //       onPressed: () {
            //             //         Navigator.pushNamed(
            //             //           context,
            //             //           AppPages.commentsPath,
            //             //           arguments: widget.post,
            //             //         );
            //             //       },
            //             //       icon: Icon(
            //             //         FontAwesomeIcons.solidCommentDots,
            //             //         color: settingsManager.darkMode
            //             //             ? Colors.grey.shade300
            //             //             : Colors.grey.shade800,
            //             //       ),
            //             //     ),
            //             //     IconButton(
            //             //       splashRadius: 20,
            //             //       onPressed: () {
            //             //         DynamicLinkService().shareProductLink(
            //             //             title: "${widget.post.title}",
            //             //             url: Uri.parse('https://aharsocialapp.in/post?id=${widget.post.postId}'),
            //             //             // url: Uri.parse('https://aharsocialapp.in/post?id=1'),
            //             //             image: '${widget.post.postUrl}');
            //             //       },
            //             //       icon: Icon(
            //             //         Icons.share_outlined,
            //             //         color: settingsManager.darkMode
            //             //             ? Colors.grey.shade300
            //             //             : Colors.grey.shade900,
            //             //       ),
            //             //     ),
            //             //   ],
            //             // ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // DottedLine(
            //   direction: Axis.horizontal,
            //   lineLength: double.infinity,
            //   lineThickness: 2.0,
            //   dashLength: 2.0,
            //   dashColor: Colors.black,
            //   dashGradient: const [Colors.red, Colors.blue],
            //   dashRadius: 9.0,
            //   dashGapLength: 9.0,
            //   dashGapColor: Colors.transparent,
            //   dashGapGradient: const [Colors.red, Colors.blue],
            //   dashGapRadius: 7.0,
            // )
          ],
        ),
      ),
    );
  }
}
