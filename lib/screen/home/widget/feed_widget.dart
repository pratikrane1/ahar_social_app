import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:aharconnect/screen/home/screens/home_screen.dart';
import 'package:aharconnect/static_data.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';

import '../../../utils/images.dart';


class FeedSlider extends StatefulWidget {
  const FeedSlider({Key? key}) : super(key: key);

  @override
  _FeedSliderState createState() => _FeedSliderState();
}

class _FeedSliderState extends State<FeedSlider>  {
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
              children:  [
                 Text(
                  "feed".tr,
                  style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                        HomeScreen(index: 1,)));
                  },
                  child:  Text(
                    "see_all".tr,
                    style:TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: ThemeColors.primaryColor,
                      fontFamily: 'Montserrat',
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
            child: PageView.builder(
              itemCount: Data().feedList!.length,
              // pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
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
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: CustomImage(
                                        image: Data().feedList![index].userImage,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(Data().feedList![index].userName ?? "",
                                            style: TextStyle(
                                                fontSize: Dimensions.fontSizeSmall,
                                                fontFamily:
                                                'Montserrat',
                                                fontWeight:
                                                FontWeight.w600,
                                                color: ThemeColors
                                                    .blackColor).copyWith(fontSize: 16)),
                                        const SizedBox(width:2,),
                                        Container(
                                          // width: 80,
                                          child: Text(Data().feedList![index].zoneName ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: Dimensions.fontSizeSmall,
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  color: ThemeColors
                                                      .blackColor).copyWith(fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    InkWell(
                                      onTap: () {},
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_EXTRA_LARGE),
                                        child: CustomImage(
                                          height: 150,
                                          width: 220,
                                          image: Data().feedList![index].postImage ?? "",
                                          fit: BoxFit.fill,
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
