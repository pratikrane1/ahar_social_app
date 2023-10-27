import 'dart:ui';

import 'package:aharconnect/controller/gallery_controller.dart';
import 'package:aharconnect/controller/home_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/view/screen/home/widget/banner_view.dart';
import 'package:aharconnect/view/screen/home/widget/document_file.dart';
import 'package:aharconnect/view/screen/home/widget/image_video_widget.dart';
import 'package:aharconnect/view/screen/notification/notification_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/feed_widget.dart';
import '../widget/noticeboard_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool loading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    Get.find<HomeController>().getBanner();
    // Get.find<ZoneController>().getFeedPostDataList("0", "Post");
    // Get.find<ZoneController>().getNoticePostList("0", "Noticboard");
    Get.find<ZoneController>().getHomeFeedPostDataList("Post");
    Get.find<GalleryController>().getAlbumList();
    Get.find<GalleryController>().getYoutubeVideos();
  }

//
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: ThemeColors.primaryColor,
        onRefresh: () async {
          await Get.find<HomeController>().getBanner();
          await Get.find<ZoneController>().getHomeFeedPostDataList("Post");
          await Get.find<ZoneController>().getHomeNoticeBoardPostDataList("Noticboard");
          await Get.find<GalleryController>().getAlbumList();
          await Get.find<GalleryController>().getYoutubeVideos();
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              toolbarHeight: 70,
              title: SizedBox(
                height: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //App Bar
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.logo,
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ahar'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: ThemeColors.blackColor),
                                  ),
                                  Text(
                                    'connect'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.blackColor),
                                  ),
                                  Text(
                                    'powered_by_wAAYU'.tr,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.blackColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen()));
                              },
                              child: const Icon(
                                Icons.notifications,
                                size: 25,
                                color: ThemeColors.blackColor,
                              ),
                            ),
                            // const SizedBox(width: 8,),
                            //
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 20.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     children: [
                            //       const SizedBox(width: 10),
                            //       IconButton(
                            //         // icon: ImageIcon(AssetImage('assets/chat.png')),
                            //         icon: const Icon(
                            //           Icons.mark_chat_unread_outlined,
                            //           size: 25,
                            //         ),
                            //         onPressed: () {
                            //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactsListScreen(),));
                            //         },
                            //         color: ThemeColors.blackColor,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Banner
                      BannerView(),

                      ///Feed Slider
                      FeedSlider(),

                      ///NoticeBoard Slider
                      NoticeboardSlider(),

                      ///Document File
                      DocumentFile(),

                      ///Gallery Widget
                      GalleryWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
