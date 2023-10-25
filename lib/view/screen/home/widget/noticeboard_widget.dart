import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/helper/download_file.dart';
import 'package:aharconnect/view/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:aharconnect/view/screen/home/widget/shimmer.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoticeboardSlider extends StatefulWidget {
  const NoticeboardSlider({Key? key}) : super(key: key);

  @override
  _NoticeboardSliderState createState() => _NoticeboardSliderState();
}

class _NoticeboardSliderState extends State<NoticeboardSlider> {
  PageController? _pageController;
  int activePage = 0;
  List<PostData>? _postDataList;
  bool _isPostDataLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    Get.find<ZoneController>().getNoticePostList("0", "Noticboard");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: GetBuilder<ZoneController>(builder: (zoneController) {
        _postDataList = zoneController.noticePostDataList;
        _isPostDataLoading = zoneController.isPostDataLoading;
        return _isPostDataLoading
            ? _postDataList!.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "notice_board".tr,
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

            ///Notice board Carousel
            SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _postDataList!.length >= 4
                              ? 4
                              : _postDataList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 15.0, top: 5),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: double.infinity,
                                ),
                                width: MediaQuery.of(context).size.width / 1.4,
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // these properties following the children content height available.

                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                80)),
                                                    // border: Border.all(width: 1),
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                    child: CustomImage(
                                                      image:
                                                          _postDataList![index]
                                                              .user!
                                                              .profilePhoto,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      _postDataList![index]
                                                                  .zone !=
                                                              null
                                                          ? _postDataList![
                                                                  index]
                                                              .zone!
                                                              .zoneName!
                                                          : "All Zone's",
                                                      style: GoogleFonts.openSans(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: ThemeColors
                                                                  .blackColor)
                                                          .copyWith(
                                                              fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 5.0,),

                                              Text(DateFormat("dd/MM/yyy").format(DateTime.parse(_postDataList![index].post!.createdAt.toString())),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.openSans(
                                                      fontSize: Dimensions.fontSizeSmall,
                                                      fontWeight: FontWeight.normal,
                                                      color: ThemeColors.blackColor)
                                                      .copyWith(fontSize: 12))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          _postDataList![index].post!.dsc ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                          style: GoogleFonts.openSans(
                                                  fontSize:
                                                      Dimensions.fontSizeDefault,
                                                  fontWeight: FontWeight.normal,
                                                  color: ThemeColors.blackColor)
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.picture_as_pdf,
                                                    color: ThemeColors.redColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Text(
                                                      _postDataList![index]
                                                          .post!
                                                          .postImage!
                                                          .split("/")
                                                          .last,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style:
                                                          GoogleFonts.openSans(
                                                              height: 1.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: InkWell(
                                                    onTap: () async {
                                                      // Get.find<ZoneController>().downloadPDF(_postDataList![index].post!.postImage!);
                                                      downloadPDF(
                                                          _postDataList![index]
                                                              .post!
                                                              .postImage!);
                                                    },
                                                    child: const Icon(
                                                        Icons.download)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ): const SizedBox()
            : ContainerShimmer(title: "notice_board");
      }),
    );
  }
}
