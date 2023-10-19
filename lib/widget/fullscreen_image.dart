import 'package:aharconnect/utils/theme_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({required this.imageUrl,super.key});
  String imageUrl;

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
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) =>
              PhotoViewGalleryPageOptions.customChild(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
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
          pageController: PageController(initialPage: 0),
          enableRotation: true,
          onPageChanged: (int index) {
          }),
    );
  }
}
