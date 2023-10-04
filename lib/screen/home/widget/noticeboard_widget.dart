import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/custom_image.dart';

import '../../../utils/images.dart';


class NoticeboardSlider extends StatefulWidget {
  const NoticeboardSlider({Key? key}) : super(key: key);

  @override
  _NoticeboardSliderState createState() => _NoticeboardSliderState();
}

class _NoticeboardSliderState extends State<NoticeboardSlider>  {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notice Board",
                  style:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  "See All",
                  style:const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: ThemeColors.primaryColor,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          ///Notice board Carousel
          SizedBox(
            // width: MediaQuery.of(context).size.width,
            // height: _width > 400.0 ? 250 : 190,
            height: 200,
            width: 500,
            child: PageView.builder(
              itemCount: 2,
              // pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0,top:16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        //<-- SEE HERE
                        width: 1,
                        color: ThemeColors.greyTextColor,
                      ),
                      borderRadius:
                      BorderRadius.circular(
                          12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(80)),
                                        // border: Border.all(width: 1),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: SvgPicture.asset(
                                          Images.transaction_logo, height: 25,
                                          // color: ThemeColors.primaryColor.withOpacity(1),
                                        ),

                                      )),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mumbai Zone | Group",
                                          style: TextStyle(
                                              fontSize: Dimensions.fontSizeSmall,
                                              fontFamily:
                                              'Montserrat',
                                              fontWeight:
                                              FontWeight.w600,
                                              color: ThemeColors
                                                  .blackColor).copyWith(fontSize: 16)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text("In publishing and graphic design, Lorem ipsum is a placeholder text "
                              "commonly used to demonstrate the visual form of a document or a typeface "
                              "without relying on meaningful content.",style: TextStyle(
                              fontSize: Dimensions.fontSizeSmall,
                              fontFamily:
                              'Montserrat',
                              fontWeight:
                              FontWeight.normal,
                              color: ThemeColors
                                  .blackColor).copyWith(fontSize: 14)),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
