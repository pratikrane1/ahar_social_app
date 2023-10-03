import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialrecipe/screen/home/screens/gallery/video/gallery_video_screen.dart';
import 'package:socialrecipe/static_data.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';
import 'package:socialrecipe/widget/custom_image.dart';

import 'Image/images_screen.dart';


class GalleryScreen extends StatefulWidget {
  bool isImage;
  GalleryScreen({Key? key,required this.isImage}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _isImage = true;
  List? _albumList;
  bool _isAlbumLoading = false;
  bool _isVideoLoading = false;
  List? _videoList;
  List? videoList1;

  @override
  void initState(){
    super.initState();
    _isImage = widget.isImage;
    if(_isImage){
      // Get.find<GalleryController>().getAlbumList();
    }else{
      // Get.find<GalleryController>().getVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
        title: Text(
          'media'.tr,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                onPressed: () async {
                  setState(() {
                    _isImage = true;
                  });
                  // Get.find<GalleryController>().getAlbumList();
                },
                height: 34,
                width: MediaQuery.of(context).size.width/2.5,
                text: Text(
                  'images'.tr,
                  style: TextStyle(
                      color: _isImage ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w700),
                ),
                loading: true,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ThemeColors.buttonColor, width: 1),
                  surfaceTintColor: ThemeColors.whiteColor,
                  backgroundColor: _isImage ? ThemeColors.buttonColor : ThemeColors.whiteColor,
                  // color:Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
              const SizedBox(width: 10,),
              AppButton(
                onPressed: () async {
                  setState(() {
                    _isImage = false;
                  });
                  // Get.find<GalleryController>().getVideos();

                },
                height: 34,
                width: MediaQuery.of(context).size.width/2.5,
                text: Text(
                  'videos'.tr,
                  style: TextStyle(
                      color: _isImage ? Colors.black : Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w700),
                ),
                loading: true,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ThemeColors.buttonColor, width: 1),
                  surfaceTintColor: ThemeColors.whiteColor,
                  backgroundColor: _isImage ? ThemeColors.whiteColor : ThemeColors.primaryColor,
                  // color:Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          ///Image Gallery
          _isImage ? Expanded(
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: Data().albumList!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagesScreen(albumData: Data().albumList![index],)));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15))
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(15)),
                            child: Stack(
                              children: [
                                // Image.network(imageList[index],fit: BoxFit.fill,),
                                CustomImage(
                                  image:  Data().albumList![index].albumImage ?? "",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(Data().albumList![index].albumName ?? "",overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w700),),
                                            ),
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor: ThemeColors.whiteColor,
                                              child: Text("+${Data().albumList![index].albumLength}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

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
                      );
                    }),
              )
          ) : SizedBox(),

          ///Video Gallery
          _isImage ? SizedBox() : Expanded(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: Data().videoList!.length,
                itemBuilder: (context, index) {
                  // DateTime dateTimeCreatedAt = DateTime.parse(_videoList![index].snippet!.publishedAt.toString());
                  // DateTime dateTimeNow = DateTime.now();
                  // final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
                  // print('$differenceInDays');
                  // if(differenceInDays <= 7){
                  //   _videoList![index].isTimePeriod = true;
                  // }
                  return Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 10.0, right: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryVideoScreen(videData: Data().videoList![index],)));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImage(
                            image: Data().videoList![index].thumbnailUrl ?? "",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                          Positioned(
                              child:Container(
                                height: 200,
                                color: Colors.black.withOpacity(0.3),
                                child: const Center(
                                  child: Icon(Icons.play_arrow,size: 60,color: ThemeColors.whiteColor,),
                                ),
                              )
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 100,
                                height: 30,
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Text("New Video".tr,
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
                  );
                },
              )
          )
        ],
      ),
    );
  }
}


