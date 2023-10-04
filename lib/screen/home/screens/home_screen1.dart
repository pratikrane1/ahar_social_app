import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialrecipe/screen/chat/screens/contacts_list_screen.dart';
import 'package:socialrecipe/screen/home/widget/banner_view.dart';
import 'package:socialrecipe/screen/home/widget/document_file.dart';
import 'package:socialrecipe/screen/home/widget/image_video_widget.dart';
import 'package:socialrecipe/screen/home/widget/videoSlider.dart';
import 'package:socialrecipe/screen/notification/notification_screens.dart';
import 'package:socialrecipe/screen/profile/profile.dart';
import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

import '../widget/feed_widget.dart';
import '../widget/noticeboard_widget.dart';


class AllTab extends StatefulWidget {
  const AllTab({Key? key}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  bool loading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
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
        onRefresh: () async {    },
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
                              Image.asset(Images.logo,height: 70,width: 70,),
                              const SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'AHAR',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'Connect',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Light',
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            // InkWell(
                            //   onTap: (){},
                            //   child: Icon(Icons.search,size: 25,),
                            // ),
                            // SizedBox(width: 18,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                              },
                              child: Icon(Icons.notifications,size: 25,),
                            ),
                            SizedBox(width: 8,),

                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 10),
                                  IconButton(
                                    // icon: ImageIcon(AssetImage('assets/chat.png')),
                                    icon: const Icon(
                                      Icons.mark_chat_unread_outlined,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactsListScreen(),));
                                    },
                                    color: ThemeColors.blackColor,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     // appProvider.gotToTab(3);
                                  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(userId: null,),));
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(),));
                                  //   },
                                  //   child: SizedBox(
                                  //     width: 35,
                                  //     height: 35,
                                  //     child:
                                  //     // user.photoUrl == "" ?
                                  //     SizedBox(
                                  //       child: ClipRRect(
                                  //         borderRadius:
                                  //         BorderRadius.circular(100),
                                  //         child: Container(
                                  //           decoration:
                                  //           const BoxDecoration(
                                  //             image: DecorationImage(
                                  //               image: AssetImage(
                                  //                   'assets/default_image.jpg'),
                                  //               fit: BoxFit.cover,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     )
                                  //     //     : SizedBox(
                                  //     //   child: ClipRRect(
                                  //     //     borderRadius:
                                  //     //     BorderRadius.circular(100),
                                  //     //     child: Container(
                                  //     //       decoration: BoxDecoration(
                                  //     //           border: Border.all(
                                  //     //             color: settingsManager
                                  //     //                 .darkMode
                                  //     //                 ? kBlackColor
                                  //     //                 : Colors.grey.shade400,
                                  //     //             width: 1.5,
                                  //     //           )),
                                  //     //       child: CachedNetworkImage(
                                  //     //         imageUrl: user.photoUrl,
                                  //     //         fit: BoxFit.cover,
                                  //     //         errorWidget:
                                  //     //             (context, url, error) =>
                                  //     //         const Center(
                                  //     //           child: FaIcon(
                                  //     //               FontAwesomeIcons
                                  //     //                   .circleExclamation),
                                  //     //         ),
                                  //     //         placeholder:
                                  //     //             (context, url) =>
                                  //     //             Shimmer.fromColors(
                                  //     //               baseColor:
                                  //     //               Colors.grey.shade400,
                                  //     //               highlightColor:
                                  //     //               Colors.grey.shade300,
                                  //     //               child: SizedBox(
                                  //     //                   height: MediaQuery.of(
                                  //     //                       context)
                                  //     //                       .size
                                  //     //                       .height /
                                  //     //                       3.3,
                                  //     //                   width:
                                  //     //                   double.infinity),
                                  //     //             ),
                                  //     //       ),
                                  //     //     ),
                                  //     //   ),
                                  //     // ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
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

                      ///DashBoard Widget
                      // DashBoardWidget(),

                      ///Our Product Widget
                      // OurProducts(),
                      NoticeboardSlider(),
                      FeedSlider(),

                      ///Video Slider
                      const VideoSlider(),

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
