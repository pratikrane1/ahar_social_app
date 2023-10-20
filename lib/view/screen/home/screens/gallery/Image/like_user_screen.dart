import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LikeUserListScreen extends StatefulWidget {
  String? photoId;
  LikeUserListScreen({required this.photoId, super.key});

  @override
  State<LikeUserListScreen> createState() => _LikeUserListScreenState();
}

class _LikeUserListScreenState extends State<LikeUserListScreen> {
  List<FeedPostLike>? _likedUserList;
  bool _isLikedImageListLoading = false;

  @override
  void initState(){
    super.initState();
    Get.find<ZoneController>().getPostLike(widget.photoId.toString(),"Post");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          "people_who_liked".tr,
          maxLines: 2,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeColors.blackColor
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: GetBuilder<ZoneController>(builder: (zoneController) {
        _likedUserList = zoneController.postLikeList;
        _isLikedImageListLoading = zoneController.isPostDataLoading;
          return _isLikedImageListLoading ? SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 15, left: 10, right: 10),
              itemCount: _likedUserList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            // border: Border.all(width: 1),
                          ),
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                            _likedUserList![index].user!.profilePhoto != null
                                ? CustomImage(
                              image: _likedUserList![index].user!.profilePhoto,
                              fit: BoxFit.cover,
                            ) :
                            SvgPicture.asset(
                              Images.avtar_icon, height: 25,
                              // color: ThemeColors.greyTextColor,
                            ),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          _likedUserList![index].user!.name ?? "",
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
              : const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
        }
      ),

    );
  }
}
