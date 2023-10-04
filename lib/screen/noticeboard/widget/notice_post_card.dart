import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/providers/dynamic_link.dart';
import 'package:socialrecipe/utils/app_pages.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/recipe_post_model.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/providers/recipe_post_provider.dart';
import 'package:socialrecipe/screen/recipe_feed/widgets/animated_like_button.dart';
import 'package:socialrecipe/screen/search_recipe/widgets/custom_drop_down.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

import 'all_notice_widget.dart';

class NoticePostCard extends StatefulWidget {
  const NoticePostCard({
    Key? key, this.noticeBoardData,
  }) : super(key: key);
  final NoticeBoardModel? noticeBoardData;
  @override
  State<NoticePostCard> createState() => _NoticePostCardState();
}

class _NoticePostCardState extends State<NoticePostCard> {
 

  @override
  Widget build(BuildContext context) {
    final settingsManager =
    Provider.of<SettingsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);

    UserModel? user = userProvider.getUser;
    final postProvider = Provider.of<RecipePostProvider>(context);
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
                      // if (currentUser!.uid != widget.post.uid) {
                      //   Navigator.pushNamed(
                      //     context,
                      //     AppPages.profilePath,
                      //     arguments: widget.post.uid,
                      //   );
                      // }
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
                          child:
                          // user == null
                          //     ? Center(
                          //   child: LinearProgressIndicator(
                          //     color: kOrangeColor,
                          //     backgroundColor: settingsManager.darkMode
                          //         ? Colors.white
                          //         : Colors.grey.shade300,
                          //   ),
                          // )
                          //     : widget.post!.profImage == ""
                          //     ?
                          // Container(
                          //   decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //       image: AssetImage(
                          //           'assets/default_image.jpg'),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // )
                              // :
                          CachedNetworkImage(
                            imageUrl: widget.noticeBoardData!.userImage ??'',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                            const Center(
                              child: FaIcon(
                                  FontAwesomeIcons.circleExclamation),
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              //username
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
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
                                      children: [
                                        Text(
                                          // widget.post!.userName,
                                          widget.noticeBoardData!.zoneName ??'',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          Theme.of(context).textTheme.bodyText2!.copyWith(fontFamily: 'Poppins-Bold'),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  widget.noticeBoardData!.postText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: widget.noticeBoardData!.postText!.length,
                                  style: Theme.of(context).textTheme.headline3!.copyWith(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0,),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.picture_as_pdf,color: ThemeColors.redColor,),
                                        const SizedBox(width: 5.0,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.61,
                                          child: Text(
                                            widget.noticeBoardData!.pdfText ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: widget.noticeBoardData!.pdfText!.length,
                                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.download)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
            const Divider(thickness: 0.8,)
          ],
        ),
      ),
    );
  }
}
