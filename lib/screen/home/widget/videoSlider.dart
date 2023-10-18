import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aharconnect/screen/home/screens/gallery/video/gallery_video_screen.dart';
import 'package:aharconnect/static_data.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';

class VideoSlider extends StatefulWidget {
  const VideoSlider({Key? key}) : super(key: key);

  @override
  _VideoSliderState createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  PageController? _pageController;
  int activePage = 0;
  List<VideoModel>? _videoList = [
    VideoModel(
        thumbnailUrl: "https://i.ytimg.com/vi/RzhiJeXMJ7g/maxresdefault.jpg",
        VideoName:
            "Shri Sandeep D Shetty , VP Zone V being felicitated on the occasion of 43rd AGM 10- 11th Jan 2023.",
        videoDesc:
            "Shri Sandeep D Shetty (Owner - Shubhalaxmi, Chembur), VP Zone V (2019 - 2021) being felicitated on the occasion of 43rd AGM held at Sahara Star, Vile Parle East on 10th & 11th January 2023.",
        VideoId: "RzhiJeXMJ7g"),
    VideoModel(
        thumbnailUrl: "https://i.ytimg.com/vi/TxaB9alUcu4/maxresdefault.jpg",
        VideoName: 'WAAYU "LEAD THE CHANGE"',
        videoDesc:
            "We bring to you WAAYU, powered by your very own AHAR, it is not only an app but a revolution.\nWe at WAAYU are very proud to introduce our solution aimed at solving all your problems in the food delivery industry. We have worked hard to create a complete application that is built to favour restaurants' answers and their business objective. With WAAYU you can now handle online ordering business with ease and efficiency",
        VideoId: "TxaB9alUcu4")
  ];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    // Get.find<VideoController>().getVideoList();
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "videos".tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),

          ///Video Carousel
          SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: _width > 400.0 ? 250 : 190,
            height: 190,
            child: PageView.builder(
              itemCount: Data().videoList!.length,
              // pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                // DateTime dateTimeCreatedAt = DateTime.parse(_videoList![pagePosition].snippet!.publishedAt.toString());
                // DateTime dateTimeNow = DateTime.now();
                // final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
                // print('$differenceInDays');
                // if(differenceInDays <= 7){
                //   _videoList![pagePosition].isTimePeriod = true;
                // }
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(RouteHelper.getGalleryVideoScreen(_videoList![pagePosition]));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GalleryVideoScreen(
                                    videData: Data().videoList![pagePosition],
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        boxShadow: const [
                          BoxShadow(
                              color: ThemeColors.greyTextColor,
                              spreadRadius: 0.8,
                              blurRadius: 2)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomImage(
                                // image: _videoList![pagePosition].snippet!.thumbnails!.high!.url,
                                image: Data()
                                    .videoList![pagePosition]
                                    .thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 60,
                                  color: ThemeColors.whiteColor,
                                ),
                              ),
                            )),
                            // _videoList![pagePosition].isTimePeriod! ?
                            // Positioned(
                            //     top: 0,
                            //     right: 0,
                            //     child: Container(
                            //       width: 100,
                            //       height: 30,
                            //       color: Colors.black.withOpacity(0.5),
                            //       child: Center(
                            //         child: Text("new_video".tr,
                            //           textAlign: TextAlign.center,
                            //           style:const TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold,
                            //               fontFamily: 'Montserrat',
                            //               color: ThemeColors.whiteColor
                            //           ),
                            //         ),
                            //       ),
                            //     )
                            // ) : Container(),
                            // _videoList![pagePosition].isTimePeriod! ? const Positioned(
                            //     top: 2,
                            //     right: 3,
                            //     child: Icon(
                            //         size: 8,
                            //         color: ThemeColors.redColor,
                            //         Icons.circle)) : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          ///Video Indicator
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(Data().videoList!.length, activePage)),
        ],
      ),
    );
  }
}

class VideoModel {
  String thumbnailUrl;
  String VideoName;
  String videoDesc;
  String VideoId;

  VideoModel(
      {required this.thumbnailUrl,
      required this.VideoName,
      required this.videoDesc,
      required this.VideoId});
}
