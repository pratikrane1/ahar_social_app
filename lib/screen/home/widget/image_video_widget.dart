import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/screen/home/screens/gallery/Image/images_screen.dart';
import 'package:socialrecipe/screen/home/screens/gallery/gallery_screen.dart';
import 'package:socialrecipe/screen/home/screens/gallery/video/gallery_video_screen.dart';
import 'package:socialrecipe/static_data.dart';

import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';
import 'package:socialrecipe/widget/custom_image.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({Key? key}) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  bool _isImage = true;
  bool _isAlbumLoading = false;
  bool _isVideoLoading = false;
  String? videoId = "";
  bool _fullScreen = false;
  List? _albumList;
  List? _videoList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.greyTextColor,
              blurRadius: 1,
              spreadRadius: 0.1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
          child: Column(
            children: [
              ///Gallery Text
               Text(
                "Gallery",
                style:const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat-Bold',
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              ///Images and Videos Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    onPressed: () async {
                      setState(() {
                        _isImage = true;
                      });
                    },
                    height: 34,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: Text(
                      'Images'.tr,
                      style: TextStyle(
                          color: _isImage ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w700),
                    ),
                    loading: true,
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: ThemeColors.whiteColor,
                      side: const BorderSide(
                          color: ThemeColors.buttonColor, width: 1),
                      backgroundColor: _isImage
                          ? ThemeColors.buttonColor
                          : ThemeColors.whiteColor,
                      // color:Colors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppButton(
                    onPressed: () async {
                      setState(() {
                        _isImage = false;
                      });
                    },
                    height: 34,
                    width: MediaQuery.of(context).size.width / 2.5,
                    text: Text(
                      'Videos'.tr,
                      style: TextStyle(
                          color: _isImage ? Colors.black : Colors.white,
                          fontSize: 18,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w700),
                    ),
                    loading: true,
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: ThemeColors.whiteColor,
                      side: const BorderSide(
                          color: ThemeColors.buttonColor, width: 1),
                      backgroundColor: _isImage
                          ? ThemeColors.whiteColor
                          : ThemeColors.primaryColor,
                      // color:Colors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              ///Images And Videos Widget
              _isImage
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImagesScreen(
                                                  albumData: Data().albumList![0],
                                                )));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(0)),
                                      child: Stack(
                                        children: [
                                          // Image.network(imageList[index],fit: BoxFit.fill,),
                                          CustomImage(
                                            image:  Data().albumList![0].albumImage,
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            // alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 25.0),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          Data().albumList![0].albumName ?? ""                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            ThemeColors
                                                                .whiteColor,
                                                        child: Text(
                                                          "+${Data().albumList![0].albumLength}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // _albumList![0].isNewAlbum == "1" ?
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                width: 100,
                                                height: 30,
                                                // color: ThemeColors.whiteColor,
                                                color: Colors.black.withOpacity(0.5),
                                                child: Center(
                                                  child: Text("New Album".tr,
                                                    textAlign: TextAlign.center,
                                                    style:const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Montserrat',
                                                        color: ThemeColors.whiteColor
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ),
                                            // : Container(),

                                          // _albumList![0].isNewAlbum == "1" ?
                                          const Positioned(
                                              top: 2,
                                              right: 3,
                                              child: Icon(
                                                  size: 8,
                                                  color: ThemeColors.redColor,
                                                  Icons.circle)),
                                            // : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Padding(
                                        padding:const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "More Images".tr,
                                          style:const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GalleryScreen(
                                                        isImage: _isImage,
                                                      )));
                                        },
                                        child:  Padding(
                                          padding:const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "See All".tr,
                                            style:const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: ThemeColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: SizedBox(
                                    height: 95,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: Data().albumList!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImagesScreen(
                                                          albumData:
                                                          Data().albumList![
                                                                  index],
                                                        )));
                                          },
                                          child: Container(
                                            // height: 90,
                                            // width: 250,
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                      .RADIUS_SMALL),
                                                  child: CustomImage(
                                                    image:  Data().albumList![index].albumImage,
                                                    fit: BoxFit.fill,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width /
                                                        3.5,
                                                    height: 120,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment
                                                      .bottomCenter,
                                                  child: Container(
                                                    height: 35,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width /
                                                        3.5,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0,
                                                          right: 0.0),
                                                      child: Center(
                                                        child: Text(
                                                          Data().albumList![index].albumName ?? "",textAlign: TextAlign.start,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              'Montserrat',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // _albumList![index].isNewAlbum == "1" ?
                                                // Positioned(
                                                //     top: 0,
                                                //     right: 0,
                                                //     child: Container(
                                                //       width: 100,
                                                //       height: 30,
                                                //       // color: ThemeColors.whiteColor,
                                                //       color: Colors.black.withOpacity(0.5),
                                                //       child: Center(
                                                //         child: Text("new_album".tr,
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
                                                // ),
                                                    // : Container(),

                                                // _albumList![index].isNewAlbum == "1" ?
                                                const Positioned(
                                                    top: 2,
                                                    right: 3,
                                                    child: Icon(
                                                        size: 8,
                                                        color: ThemeColors.redColor,
                                                        Icons.circle)),
                                                // : Container(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )

              ///Video Widget
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryVideoScreen(videData: Data().videoList![0],)));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImage(
                            image: Data().videoList![0].thumbnailUrl ?? "",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                          Positioned(
                              child: Container(
                                height: 200,
                                color: Colors.black.withOpacity(0.3),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 60,
                                    color: ThemeColors.whiteColor,
                                  ),
                                ),
                              )),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 100,
                                height: 30,
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Text("new_video".tr,
                                    textAlign: TextAlign.center,
                                    style:const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: ThemeColors.whiteColor
                                    ),
                                  ),
                                ),
                              )
                          ),
                          const Positioned(
                              top: 2,
                              right: 3,
                              child: Icon(
                                  size: 8,
                                  color: ThemeColors.redColor,
                                  Icons.circle)),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "More Videos".tr,
                            style:const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GalleryScreen(
                                      isImage: _isImage,
                                    )));
                          },
                          child:  Padding(
                            padding:const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "See All".tr,
                              style:const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: ThemeColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: SizedBox(
                      height: 85,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: Data().videoList!.length,
                        itemBuilder: (context, index) {
                          // DateTime dateTimeCreatedAt = DateTime.parse(_videoList![index].snippet!.publishedAt.toString());
                          // DateTime dateTimeNow = DateTime.now();
                          // final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
                          // print('$differenceInDays');
                          // if(differenceInDays <= 7){
                          //   _videoList![index].isTimePeriod = true;
                          // }
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryVideoScreen(videData: Data().videoList![index],)));
                            },
                            child: Container(
                              // height: 90,
                              // width: 250,
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomImage(
                                      image: Data().videoList![index].thumbnailUrl ?? "",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width / 3.5,
                                      height: 120,
                                    ),
                                    Positioned(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          height: 120,
                                          color: Colors.black.withOpacity(0.3),
                                          child: const Center(
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 50,
                                              color: ThemeColors.whiteColor,
                                            ),
                                          ),
                                        )),

                                    // _videoList![index].isTimePeriod! ?
                                    const Positioned(
                                        top: 2,
                                        right: 3,
                                        child: Icon(
                                            size: 8,
                                            color: ThemeColors.redColor,
                                            Icons.circle)),
                                    // : Container(),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AlbumList{
  String? albumName;
  String? albumLength;
  String? albumImage;
  List<AlbumImages>? albumImages;
  AlbumList({required this.albumName,required this.albumImage,required this.albumLength,required this.albumImages});
}

class AlbumImages{
  int? likeCount;
  String? albumImages;
  AlbumImages({required this.likeCount,required this.albumImages});
}