import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/helper/dynamic_link.dart';
import 'package:aharconnect/screen/comment/screens/comments_screen.dart';
import 'package:aharconnect/screen/recipe_feed/widgets/animated_like_button.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupFeedWidget extends StatefulWidget {
  GroupFeedWidget({required this.zoneId, required this.type, Key? key})
      : super(key: key);
  String zoneId;
  String type;

  @override
  State<GroupFeedWidget> createState() => _GroupFeedWidgetState();
}

class _GroupFeedWidgetState extends State<GroupFeedWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _phoneController = TextEditingController();
  List<PostData>? _postDataList;
  bool _isPostDataLoading = false;
  List<FeedPostLike>? _postLikeList;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
    Get.find<ZoneController>().getFeedPostDataList(widget.zoneId, widget.type);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  Future<void> refreshTab() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      Get.find<ZoneController>()
          .getFeedPostDataList(widget.zoneId, widget.type);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        extendBody: true,
        body: RefreshIndicator(
          onRefresh: refreshTab,
          color: ThemeColors.primaryColor,
          backgroundColor: Colors.white,
          child: GetBuilder<ZoneController>(builder: (zoneController) {
            _postDataList = zoneController.postDataList;
            _isPostDataLoading = zoneController.isPostDataLoading;
            return _isPostDataLoading
                ? _postDataList!.isNotEmpty
                    ? SingleChildScrollView(
                        //padding: EdgeInsets.only(bottom: 50),
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: snapshot.data!.docs.length,
                          itemCount: _postDataList!.length,
                          itemBuilder: ((context, index) {
                            return _postDataList!.isNotEmpty
                                ? Container(
                                    // width: screenWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // User image and user name section.
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: screenWidth -
                                                  (screenWidth - 15),
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    elevation: 8,
                                                    shadowColor: Colors.grey
                                                        .withOpacity(0.2),
                                                    child: SizedBox(
                                                      width: 44,
                                                      height: 44,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: CustomImage(
                                                          image: _postDataList![
                                                                  index]
                                                              .user!
                                                              .profilePhoto,
                                                          fit: BoxFit.cover,
                                                          fromProfile: true,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    _postDataList![index]
                                                                            .user!
                                                                            .name!
                                                                            .split(" ")
                                                                            .elementAt(0) ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _postDataList![index].zone !=
                                                                              null
                                                                          ? _postDataList![index]
                                                                              .zone!
                                                                              .zoneName!
                                                                          : "All Zone",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.openSans(
                                                                          color: ThemeColors
                                                                              .greyTextColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            //Post Image
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Material(
                                                                elevation: 8,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                shadowColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.1),
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          screenHeight /
                                                                              4.2,
                                                                      width:
                                                                          screenWidth /
                                                                              1.5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade400,
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child:
                                                                            CustomImage(
                                                                          image: _postDataList![index]
                                                                              .post!
                                                                              .postImage,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          fromProfile:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            //Post Title
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Text(
                                                                _postDataList![
                                                                            index]
                                                                        .post!
                                                                        .dsc ??
                                                                    "",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: _postDataList![index]
                                                                            .post!
                                                                            .dsc !=
                                                                        null
                                                                    ? _postDataList![
                                                                            index]
                                                                        .post!
                                                                        .dsc!
                                                                        .length
                                                                    : null,
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),

                                                            ///Like && Comment & Share Button
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  //!: Like button:
                                                                  AnimatedLikeButton(
                                                                    isAnimating: true ==
                                                                            null
                                                                        ? false
                                                                        : true,
                                                                    child: Row(
                                                                      children: [
                                                                        IconButton(
                                                                          splashRadius:
                                                                              20,
                                                                          onPressed:
                                                                              () async {
                                                                            if (_postDataList![index].post!.islike ==
                                                                                1) {
                                                                              setState(() {
                                                                                _postDataList![index].post!.islike = 0;
                                                                              });
                                                                              Get.find<ZoneController>().addPostLike(_postDataList![index].post!.id.toString(), '0', widget.zoneId, widget.type);
                                                                            } else {
                                                                              setState(() {
                                                                                _postDataList![index].post!.islike = 1;
                                                                              });
                                                                              Get.find<ZoneController>().addPostLike(_postDataList![index].post!.id.toString(), '1', widget.zoneId, widget.type);
                                                                            }
                                                                          },
                                                                          icon: _postDataList![index].post!.islike == 1
                                                                              ? const Icon(
                                                                                  CupertinoIcons.heart_fill,
                                                                                  color: ThemeColors.redColor,
                                                                                )
                                                                              : const FaIcon(
                                                                            FontAwesomeIcons
                                                                                .heart,
                                                                            size: 23,
                                                                            color: ThemeColors
                                                                                .greyTextColor,
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap: ()async{
                                                                            if(_postDataList![index].post!.likes != "0"){
                                                                              _postLikeList = await Get.find<ZoneController>().getPostLike(_postDataList![index].postId.toString());
                                                                              ShowModelBottomSheet(_postLikeList!);
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            _postDataList![index].post!.likes != "0"
                                                                                ? '${_postDataList![index].post!.likes} ${_postDataList![index].post!.likes == 1 ? "Like" : "Likes"}'
                                                                                : "",
                                                                            style:
                                                                                GoogleFonts.openSans(),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // SizedBox(width: 30,),
                                                                  // Comment Button
                                                                  IconButton(
                                                                    splashRadius:
                                                                        20,
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                                      CommentsScreen(postData: _postDataList![index],)));
                                                                    },
                                                                    icon:
                                                                        const FaIcon(
                                                                      FontAwesomeIcons
                                                                          .comment,
                                                                      size: 23,
                                                                      color: ThemeColors
                                                                          .greyTextColor,
                                                                    ),
                                                                  ),
                                                                  // SizedBox(width: 30,),

                                                                  //Share Button
                                                                  IconButton(
                                                                    splashRadius:
                                                                        20,
                                                                    onPressed:
                                                                        () {
                                                                      DynamicLinkService().shareProductLink(
                                                                          title: "${_postDataList![index].post!.dsc}",
                                                                          url: Uri.parse('https://aharsocialapp.in/post?postId=${_postDataList![index].post!.id}&zoneId=${widget.zoneId}'),
                                                                          // url: Uri.parse('https://aharsocialapp.in/post?id=1'),
                                                                          image: '${_postDataList![index].post!.postImage}');
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .share_outlined,
                                                                      color: ThemeColors
                                                                          .greyIconColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // PopupMenuButton(
                                                //   splashRadius: 20,
                                                //   icon: Icon(
                                                //     Icons.more_vert,
                                                //     size: 18,
                                                //     color: Colors.grey.shade300,
                                                //   ),
                                                //   onSelected: (String value) {
                                                //     // if (value == 'Delete') {
                                                //     //   Provider.of<RecipePostProvider>(context,
                                                //     //           listen: false)
                                                //     //       .deletePost(widget.post.postId);
                                                //     // }
                                                //   },
                                                //   itemBuilder: (BuildContext context) {
                                                //     return popUpMenuItems
                                                //         .map<CustomDropDownMenu<String>>(
                                                //           (String value) => CustomDropDownMenu(
                                                //         value: value,
                                                //         text: value,
                                                //         isRemovable: false,
                                                //         callback: () {
                                                //           setState(
                                                //                 () {
                                                //               FocusScope.of(context).unfocus();
                                                //               popUpMenuItems.remove(value);
                                                //               Navigator.pop(context);
                                                //             },
                                                //           );
                                                //         },
                                                //       ),
                                                //     )
                                                //         .toList();
                                                //   },
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 0.8,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "No Data Found",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeColors.blackColor),
                                    ),
                                  );
                          }),
                        ),
                      )
                    : Center(
                        child: Text(
                          "No Data Found",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.blackColor),
                        ),
                      )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.primaryColor,
                    ),
                  );
          }),
        ),
      ),
    );
  }
  void ShowModelBottomSheet(List<FeedPostLike>? _postLikeList) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: _postLikeList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.11,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(100)),
                            border: Border.all(width: 1),
                          ),
                          height: 30,
                          width: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomImage(
                              image: _postLikeList[
                              index]
                                  .user!
                                  .profilePhoto,
                              fit: BoxFit.cover,
                              fromProfile: true,
                            ),
                          )),
                      const SizedBox(width: 5,),
                      Text(_postLikeList[index].user!.name.toString(),
                          style: GoogleFonts.openSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}

