import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

import 'custom_image.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? rawFile;
  final String? image;
  final void Function()? onTap;
  ImagePickerWidget({@required this.rawFile, @required this.image, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(child: Stack(children: [

      ClipOval(
          child:
          rawFile != null ? Image.memory(
        rawFile!, width: 100, height: 100, fit: BoxFit.cover,) :
          CustomImage(image: image, height: 100, width: 100, fit: BoxFit.cover,fromProfile: true,)),

      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: onTap!,
          child: CircleAvatar(
            radius: 17,
            backgroundColor: ThemeColors.whiteColor,
            child: const Icon(
              Icons.edit,
              size: 20,
              color: ThemeColors.blackColor,
            ),
          ),
        ),
      ),
    ]));
  }
}

class ImageWidget extends StatelessWidget {
  final Uint8List? rawFile;
  final String? image;
 // final void Function()? onTap;
  ImageWidget({@required this.rawFile, @required this.image,
    //@required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Stack(children: [

      ClipOval(
          child:
          rawFile != null ? Image.memory(
            rawFile!, width: 100, height: 100, fit: BoxFit.cover,) :
          CustomImage(image: image, height: 150, width: 150, fit: BoxFit.cover,fromProfile: true,)),

      // Positioned(
      //   bottom: 0,
      //   right: 0,
      //   child: InkWell(
      //     //onTap: onTap!,
      //     child: CircleAvatar(
      //       radius: 17,
      //       backgroundColor: ThemeColors.whiteColor,
      //       child: const Icon(
      //         Icons.edit,
      //         size: 20,
      //         color: ThemeColors.blackColor,
      //       ),
      //     ),
      //   ),
      // ),
    ]));
  }
}
