import 'package:aharconnect/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/static_data.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



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

  @override
  Widget build(BuildContext context) {

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
                  "notice_board".tr,
                  style:GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                        BottomNavBar(index: 1,)));
                  },
                  child: Text(
                    "see_all",
                    style:GoogleFonts.openSans(
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
            height: 240,
            child: PageView.builder(
              itemCount: Data().noticeBoardList!.length,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, index) {
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
                                        child: CustomImage(
                                          image: Data().noticeBoardList![index].userImage,
                                          fit: BoxFit.fill,
                                        ),

                                      )),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Data().noticeBoardList![index].zoneName ?? "",
                                          style: GoogleFonts.openSans(
                                              fontSize: Dimensions.fontSizeSmall,
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
                          Text(Data().noticeBoardList![index].postText ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: GoogleFonts.openSans(
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight:
                              FontWeight.normal,
                              color: ThemeColors
                                  .blackColor).copyWith(fontSize: 14)),
                          const SizedBox(height: 5.0,),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.picture_as_pdf,color: ThemeColors.redColor,),
                                    const SizedBox(width: 5.0,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.61,
                                      child: Text(
                                        Data().noticeBoardList![index].pdfText ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.openSans(
                                            height: 1.5,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.download)
                              ],
                            ),
                          )  ,
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
