import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/custom_image.dart';


class VideoSlider extends StatefulWidget {
  const VideoSlider({Key? key}) : super(key: key);

  @override
  _VideoSliderState createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider>  {
  PageController? _pageController;
  int activePage = 0;
  // List? _videoList;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9,initialPage: 0);
    // Get.find<VideoController>().getVideoList();
  }

  List<Widget> indicators(imagesLength,currentIndex) {
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

    return  Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "gainz_pro_training_video".tr,
              style:const TextStyle(
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
              itemCount: 1,
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.RADIUS_DEFAULT),
                        boxShadow: const [BoxShadow(color: ThemeColors.greyTextColor, spreadRadius: 0.8, blurRadius: 2)],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.RADIUS_DEFAULT),
                        child: Stack(
                          alignment: Alignment.center,

                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomImage(
                                // image: _videoList![pagePosition].snippet!.thumbnails!.high!.url,
                                image: "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                child:Container(
                                  color: Colors.black.withOpacity(0.3),
                                  child: const Center(
                                    child: Icon(Icons.play_arrow,size: 60,color: ThemeColors.whiteColor,),
                                  ),
                                )
                            ),
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
          const SizedBox(height: 10,),
          ///Video Indicator
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(1,activePage)),
        ],
      ),
    );
  }
}
