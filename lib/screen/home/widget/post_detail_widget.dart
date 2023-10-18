import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/helper/dynamic_link.dart';
import 'package:aharconnect/screen/recipe_feed/widgets/animated_like_button.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen({this.postId,this.zoneId, super.key});
  String? postId;
  String? zoneId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<PostData>? _postDataList;
  bool _isPostDataLoading = false;

  @override
  void initState(){
    super.initState();
    Get.find<ZoneController>().getPostDataList(widget.zoneId!, widget.postId!);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          'post'.tr,
          style: GoogleFonts.openSans(
              fontSize: 25,
              color: ThemeColors.blackColor,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
      body: GetBuilder<ZoneController>(builder: (zoneController) {
        _postDataList = zoneController.postDataList;
        _isPostDataLoading = zoneController.isPostDataLoading;
        return _isPostDataLoading
            ? _postDataList != null
          ? SingleChildScrollView(
            child: Container(
              // width: screenWidth,
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
                            onTap: () {},
                            child: Material(
                              borderRadius: BorderRadius.circular(50),
                              elevation: 8,
                              shadowColor: Colors.grey.withOpacity(0.2),
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomImage(
                                    image: _postDataList![0].user!.profilePhoto,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _postDataList![0].user!.name!
                                                      .split(" ")
                                                      .elementAt(0) ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                _postDataList![0].zone != null
                                                    ? _postDataList![0].zone!
                                                        .zoneName!
                                                    : "All Zone",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.openSans(
                                                    color:
                                                        ThemeColors.greyTextColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),
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
                                          borderRadius: BorderRadius.circular(20),
                                          shadowColor: Colors.grey.withOpacity(0.1),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: screenHeight / 4.2,
                                                width: screenWidth / 1.5,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CustomImage(
                                                    image: _postDataList![0]
                                                        .post!.postImage,
                                                    fit: BoxFit.cover,
                                                    fromProfile: false,
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
                                      Text(
                                        _postDataList![0].post!.dsc ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: _postDataList![0].post!.dsc !=
                                                null
                                            ? _postDataList![0].post!.dsc!.length
                                            : null,
                                        style: GoogleFonts.openSans(
                                          fontSize: 12,
                                        ),
                                      ),
                                      //Like && Comment & Share Button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //!: Like button:
                                          AnimatedLikeButton(
                                            isAnimating:
                                                true == null ? false : true,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  splashRadius: 20,
                                                  onPressed: () async {
                                                    if (_postDataList![0].post!
                                                            .islike ==
                                                        1) {
                                                      Get.find<ZoneController>()
                                                          .addPostLike(
                                                          _postDataList![0]
                                                                  .post!.id
                                                                  .toString(),
                                                              '0',
                                                              "0",
                                                              "Post");
                                                    } else {
                                                      Get.find<ZoneController>()
                                                          .addPostLike(
                                                          _postDataList![0]
                                                                  .post!.id
                                                                  .toString(),
                                                              '1',
                                                              "0",
                                                              "Post");
                                                    }
                                                  },
                                                  icon: _postDataList![0].post!
                                                              .islike ==
                                                          1
                                                      ? const Icon(
                                                          CupertinoIcons.heart_fill,
                                                          color:
                                                              ThemeColors.redColor,
                                                        )
                                                      : const FaIcon(
                                                    FontAwesomeIcons
                                                        .heart,
                                                    size: 23,
                                                    color: ThemeColors
                                                        .greyTextColor,
                                                  ),
                                                ),
                                                Text(
                                                  _postDataList![0].post!
                                                              .likes !=
                                                          "0"
                                                      ? '${_postDataList![0].post!.likes} ${_postDataList![0].post!.likes == 1 ? "Like" : "Likes"}'
                                                      : "",
                                                  style: GoogleFonts.openSans(),
                                                ),
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
                                            icon: const Icon(
                                              Icons.comment,
                                              color: ThemeColors.greyIconColor,
                                            ),
                                          ),
                                          // SizedBox(width: 30,),

                                          //Share Button
                                          IconButton(
                                            splashRadius: 20,
                                            onPressed: () {
                                              DynamicLinkService().shareProductLink(
                                                  title: "${_postDataList![0].post!.dsc}",
                                                  url: Uri.parse('https://aharsocialapp.in/post?postId=${_postDataList![0].post!.id}&&zoneId=${widget.zoneId}'),
                                                  // url: Uri.parse('https://aharsocialapp.in/post?id=1'),
                                                  image: '${_postDataList![0].post!.postImage}');
                                            },
                                            icon: const Icon(
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
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.8,
                    )
                  ],
                ),
              ),
            ),
          )
        : const SizedBox()
            : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
        }
      ),
    );
  }
}
