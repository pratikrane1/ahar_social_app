import 'dart:io';
import 'package:aharconnect/controller/gallery_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/gallery_model.dart';
import 'package:aharconnect/view/widget/custom_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'album_image_view.dart';
import 'like_user_screen.dart';

class ImagesScreen extends StatefulWidget {
  AlbumModel? albumData;
  ImagesScreen({Key? key, required this.albumData}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  List<AlbumImageModel>? _albumImagesList;
  bool _isAlbumImages = false;

  @override
  void initState() {
    super.initState();
    Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(), false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
        title: Text(
          widget.albumData!.name ?? "",
          maxLines: 2,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeColors.blackColor
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
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: RefreshIndicator(
        color: ThemeColors.primaryColor,
        onRefresh: () async {
          await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(), false);
        },
        child: GetBuilder<GalleryController>(builder: (galleryController) {
          _albumImagesList = galleryController.albumImagesList;
          _isAlbumImages = galleryController.isAlbumImagesLoading;
          return _isAlbumImages
              ? _albumImagesList!.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MasonryGridView.count(
                                itemCount: _albumImagesList!.length,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageViewerScreen(
                                                        albumImage:
                                                        _albumImagesList!,
                                                        initialIndex: index,
                                                        albumData:
                                                            widget.albumData!,
                                                      )));
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            child: CustomImage(
                                              image: _albumImagesList![index]
                                                  .url
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              // width: MediaQuery.of(context).size.width,
                                              // height: 200,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0,
                                            right: 6.0,
                                            bottom: 10.0,
                                            top: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      if (_albumImagesList![index].isLike == 1) {
                                                        Get.find<ZoneController>().addPostLike(_albumImagesList![index].id.toString(), '0', "0", "",true,widget.albumData!.id.toString());
                                                      } else {
                                                        Get.find<ZoneController>().addPostLike(_albumImagesList![index].id.toString(), '1', "0", "",true,widget.albumData!.id.toString());
                                                      }
                                                    },
                                                    child: Icon(
                                                        _albumImagesList![index]
                                                                    .isLike !=
                                                                1
                                                            ? CupertinoIcons
                                                                .heart
                                                            : CupertinoIcons
                                                                .heart_fill,
                                                        color: _albumImagesList![
                                                                        index]
                                                                    .isLike ==
                                                                1
                                                            ? ThemeColors
                                                                .redColor
                                                            : null,
                                                        size: 20)),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    _albumImagesList![index]
                                                                .likeCount !=
                                                            0
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LikeUserListScreen(
                                                                          photoId: _albumImagesList![index]
                                                                              .id
                                                                              .toString(),
                                                                        )))
                                                        : null;
                                                  },
                                                  child: Text(
                                                    _albumImagesList![index]
                                                                .likeCount !=
                                                            "0"
                                                        ? "${_albumImagesList![index].likeCount} ${_albumImagesList![index].likeCount == "1" ? "Like" : "Likes"}"
                                                        : "",
                                                    style: GoogleFonts.openSans(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 13,
                                                        color: ThemeColors
                                                            .blackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.find<
                                                            GalleryController>()
                                                        .shareImage(
                                                            _albumImagesList![
                                                                    index]
                                                                .url!,
                                                            _albumImagesList![
                                                                index],
                                                            widget.albumData!);
                                                  },
                                                  child: SvgPicture.asset(
                                                    Images.share_icon,
                                                    height: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                _albumImagesList![index]
                                                            .totalShare !=
                                                        0
                                                    ? Text(
                                                        "(${_albumImagesList![index].totalShare ?? 0})",
                                                        style: GoogleFonts.openSans(
                                                            fontSize: 13,
                                                            color: ThemeColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              // height: 40,
                              // width: 40,

                              child: Image.asset(Images.empty_images),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "oops_looks_like_there_are_no_images_available_right_now"
                                .tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.primaryColor,
                  ),
                );
        }),
      ),
    );
  }
}

class AlbumImageProvider extends EasyImageProvider {
  // final List<AlbumImagesModel> albumImage;
  final List albumImage;
  final int initialIndex;

  AlbumImageProvider({required this.albumImage, this.initialIndex = 0});

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    String? localImagePath = albumImage[index].photoUrl;
    File? imageFile;

    if (localImagePath != null) {
      imageFile = File(localImagePath);
    }

    ImageProvider imageProvider = imageFile != null
        ? Image.network(albumImage[index].photoUrl.toString()).image
        : AssetImage(Images.placeholder) as ImageProvider;

    return imageProvider;
  }

  @override
  int get imageCount => albumImage.length;
}
