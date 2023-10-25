import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/view/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:aharconnect/view/screen/home/widget/shimmer.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:aharconnect/view/widget/fullscreen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FeedSlider extends StatefulWidget {
  const FeedSlider({Key? key}) : super(key: key);

  @override
  _FeedSliderState createState() => _FeedSliderState();
}

class _FeedSliderState extends State<FeedSlider> {
  PageController? _pageController;
  int activePage = 0;
  // List? _videoList;
  List<PostData>? _postDataList;
  bool _isPostDataLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    Get.find<ZoneController>().getFeedPostDataList("0", "Post");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoneController>(builder: (zoneController) {
      _postDataList = zoneController.postDataList;
      _isPostDataLoading = zoneController.isPostDataLoading;
      return _isPostDataLoading
          ? _postDataList != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "feed".tr,
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar(
                                              index: 1,
                                            )));
                              },
                              child: Text(
                                "see_all".tr,
                                style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Feed Carousel
                      SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        // height: _width > 400.0 ? 250 : 190,
                        height: 200,
                        // width: 355,
                        child: ListView.builder(
                          itemCount: _postDataList!.length >= 4
                              ? 4
                              : _postDataList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 15.0, top: 5),
                              child: InkWell(
                                onTap: () {
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.4,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_DEFAULT),
                                    // boxShadow: const [BoxShadow(color: ThemeColors.greyTextColor, spreadRadius: 0.8, blurRadius: 2)],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        //<-- SEE HERE
                                        width: 1,
                                        color: ThemeColors.greyTextColor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(80)),
                                                // border: Border.all(width: 1),
                                              ),
                                              height: 50,
                                              width: 50,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: CustomImage(
                                                  image: _postDataList![index]
                                                      .user!
                                                      .profilePhoto,
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      _postDataList![index]
                                                              .user!
                                                              .name
                                                              // .split(" ")
                                                              // .elementAt(0)
                                                          ??
                                                          "",
                                                      style: GoogleFonts.openSans(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: ThemeColors
                                                                  .blackColor)
                                                          .copyWith(
                                                              fontSize: 16)),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                      _postDataList![
                                                                      index]
                                                                  .zone !=
                                                              null
                                                          ? _postDataList![
                                                                  index]
                                                              .zone!
                                                              .zoneName!
                                                          : "All Zone's",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.openSans(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: ThemeColors
                                                                  .blackColor)
                                                          .copyWith(
                                                              fontSize: 12)),
                                                ],
                                              ),
                                              Text(DateFormat("dd/MM/yyy").format(DateTime.parse(_postDataList![index].post!.createdAt.toString())),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: Dimensions.fontSizeSmall,
                                                      fontWeight: FontWeight.normal,
                                                      color: ThemeColors.blackColor)
                                                      .copyWith(fontSize: 12)),

                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .RADIUS_EXTRA_LARGE),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                          FullScreenImage(imageUrl: _postDataList![index].post!.postImage.toString(),)));
                                                    },
                                                    child: CustomImage(
                                                      // height: 150,
                                                      // height: MediaQuery.of(context).size.height / 5.5,
                                                      // // width: 220,
                                                      width: MediaQuery.of(context).size.width / 2.3,
                                                      image: _postDataList![index]
                                                              .post!
                                                              .postImage ??
                                                          "",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox()
          : ContainerShimmer(title: "feed",);
    });
  }
}
