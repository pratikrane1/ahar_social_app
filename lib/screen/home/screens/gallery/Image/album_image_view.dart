import 'package:aharconnect/controller/gallery_controller.dart';
import 'package:aharconnect/data/model/gallery_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';


class ImageViewerScreen extends StatefulWidget {
  ImageViewerScreen(
      {required this.albumImage,
      required this.initialIndex,
      required this.albumData,
      Key? key})
      : super(key: key);

  List<AlbumImageModel>? albumImage;
  final int initialIndex;
  AlbumModel? albumData;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  String? currentImageUrl;
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: widget.initialIndex);
    currentImageUrl = widget.albumImage![widget.initialIndex].url ?? "";
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.blackColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        // actions: [
        //   IconButton(
        //     splashRadius: 20,
        //     onPressed: () async {
        //       Get.find<GalleryController>().shareImage(currentImageUrl!);
        //     },
        //     icon: const Icon(
        //       Icons.share,
        //       color: Colors.white,
        //       size: 24,
        //     ),
        //   ),
        // ],
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: Column(children: [
        Expanded(
            child: Stack(children: [
          PhotoViewGallery.builder(
              itemCount: widget.albumImage!.length,
              builder: (context, index) =>
                  PhotoViewGalleryPageOptions.customChild(
                    child: CachedNetworkImage(
                      imageUrl: widget.albumImage![index].url.toString(),
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.red.shade400,
                      ),
                    ),
                    minScale: PhotoViewComputedScale.covered,
                    // heroAttributes: PhotoViewHeroAttributes(
                    //     tag: widget.albumImage[index].id.toString()),
                  ),
              pageController: PageController(initialPage: widget.initialIndex),
              enableRotation: true,
              onPageChanged: (int index) {
                // currentImageUrl = widget.albumImage[index].photoUrl;
                // currentIndex = index;
                // setState(() {
                //   widget.albumImage[index].isLike = widget.albumImage[index].isLike;
                //   widget.albumImage[index].likeCount = widget.albumImage[index].likeCount;
                //   widget.albumImage[index].totalShare = widget.albumImage[index].totalShare;
                //
                // });
              }),
        ])),
      ]),
      bottomNavigationBar: Container(
        color: ThemeColors.blackColor,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        // if(widget.albumImage[currentIndex!].isLike == "1"){
                        //   Get.find<GalleryController>().setLikeUnlikePhoto(Get.find<AuthController>().getUserId(),
                        //       widget.albumData!.id.toString(),widget.albumImage[currentIndex!].id.toString(),0.toString()).
                        // then((value) async {
                        //   if(value.status == 1){
                        //     await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
                        //
                        //     setState(()  {
                        //       widget.albumImage[currentIndex!].isLike = Get.find<GalleryController>().albumImagesList[currentIndex!].isLike;
                        //       widget.albumImage[currentIndex!].isLike;
                        //       widget.albumImage[currentIndex!].likeCount = Get.find<GalleryController>().albumImagesList[currentIndex!].likeCount;
                        //     });
                        //   }
                        //   });
                        // }else{
                        //   Get.find<GalleryController>().setLikeUnlikePhoto(Get.find<AuthController>().getUserId(),
                        //       widget.albumData!.id.toString(),widget.albumImage[currentIndex!].id.toString(),1.toString()).
                        //   then((value) async{
                        //     if(value.status == 1){
                        //       await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
                        //
                        //       setState(()  {
                        //         widget.albumImage[currentIndex!].isLike = Get.find<GalleryController>().albumImagesList[currentIndex!].isLike;
                        //         widget.albumImage[currentIndex!].isLike;
                        //         widget.albumImage[currentIndex!].likeCount = Get.find<GalleryController>().albumImagesList[currentIndex!].likeCount;
                        //       });
                        //     }
                        //   });
                        // }
                      },
                      child: Icon(
                          widget.albumImage![currentIndex!].likeCount != "1"
                              ? CupertinoIcons.heart
                              : CupertinoIcons.heart_fill,
                          color:
                              widget.albumImage![currentIndex!].likeCount == "1"
                                  ? ThemeColors.redColor
                                  : ThemeColors.whiteColor,
                          size: 25)),
                  // const Icon(CupertinoIcons.heart,
                  //     size: 25, color: ThemeColors.whiteColor),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // widget.albumImage[currentIndex!].likeCount != 0 ?
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      //     LikeUserListScreen(photoId: widget.albumImage[currentIndex!].id.toString(),))) : null;
                    },
                    child: Text(
                      widget.albumImage![currentIndex!].likeCount != 0
                          ? "${widget.albumImage![currentIndex!].likeCount} ${widget.albumImage![currentIndex!].likeCount == 1 ? "Like" : "Likes"}"
                          : "",
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: ThemeColors.whiteColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.find<GalleryController>().shareImage(currentImageUrl!,
                          widget.albumImage![currentIndex!],widget.albumData!).
                      then((value) async{
                        if(value == 1){
                          // await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
                          //
                          // setState(()  {
                          //   widget.albumImage![currentIndex!].isLike = Get.find<GalleryController>().albumImagesList[currentIndex!].isLike;
                          //   widget.albumImage![currentIndex!].isLike;
                          //   widget.albumImage![currentIndex!].likeCount = Get.find<GalleryController>().albumImagesList[currentIndex!].likeCount;
                          //   widget.albumImage![currentIndex!].totalShare = Get.find<GalleryController>().albumImagesList[currentIndex!].totalShare;
                          //   widget.albumImage![currentIndex!].totalShare;
                          // });
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      Images.share_icon,
                      height: 25,
                      color: ThemeColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  widget.albumImage![currentIndex!].likeCount != 0
                      ? Text(
                          "(${widget.albumImage![currentIndex!].likeCount ?? 0})",
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.whiteColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
