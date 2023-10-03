import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialrecipe/screen/home/widget/image_video_widget.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/custom_image.dart';
import 'package:http/http.dart' as http;

import 'album_image_view.dart';


class ImagesScreen extends StatefulWidget {
  AlbumList? albumData;
  ImagesScreen({Key? key,
    required this.albumData
  }) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {

  List? _albumImagesList;


  @override
  void initState(){
    super.initState();
    // Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        surfaceTintColor: ThemeColors.whiteColor,
        title: Text(
          widget.albumData!.albumName ?? "",
          maxLines: 2,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 18,
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
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: RefreshIndicator(
        color: ThemeColors.primaryColor,
        onRefresh: ()async{
          // await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
        },
        child:  Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                    itemCount: widget.albumData!.albumImages!.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder:(context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewerScreen(albumImage: widget.albumData!.albumImages!,initialIndex: index,albumData: widget.albumData!,)));

                              // Get.to(() => ImageViewerScreen(albumImage: _albumImagesList!,initialIndex: index,albumData: widget.albumData!,));
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
                                child: CustomImage(
                                  image: widget.albumData!.albumImages![index].albumImages.toString(),
                                  fit: BoxFit.cover,
                                  // width: MediaQuery.of(context).size.width,
                                  // height: 200,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0,right: 6.0,bottom: 10.0,top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                Row(
                                  children: [

                                    InkWell(
                                        onTap: (){
                                        },
                                        child: Icon(widget.albumData!.albumImages![index].likeCount != "1" ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
                                            color:widget.albumData!.albumImages![index].likeCount == "1" ? ThemeColors.redColor : null,
                                            size: 20)),
                                    const SizedBox(width: 4,),
                                    InkWell(
                                      onTap: (){
                                        if(widget.albumData!.albumImages![index].likeCount != 1) {
                                          setState(() {
                                            widget
                                                .albumData!
                                                .albumImages![index]
                                                .likeCount = 1;
                                          });
                                        }else{
                                          setState(() {
                                            widget.albumData!.albumImages![index].likeCount = 0;
                                          });
                                        }
                                      },
                                      child: Text(widget.albumData!.albumImages![index].likeCount != 0 ?
                                      "${widget.albumData!.albumImages![index].likeCount} ${widget.albumData!.albumImages![index].likeCount == 1 ? "Like" : "Likes"}" : "",
                                        style:const TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 13,
                                            color: ThemeColors.blackColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500),),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: ()async{
                                        final uri = Uri.parse(widget.albumData!.albumImages![index].albumImages.toString());
                                        final response = await http.get(uri);
                                        final bytes = response.bodyBytes;
                                        final temp = await getTemporaryDirectory();
                                        final path = '${temp.path}/image.jpg';
                                        File(path).writeAsBytesSync(bytes);
                                        await Share.shareFiles([path],);
                                      },
                                      child: SvgPicture.asset(
                                        Images.share_icon,
                                        height: 20,
                                      ),),
                                    const SizedBox(width: 2,),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class AlbumImageProvider extends EasyImageProvider {

  // final List<AlbumImagesModel> albumImage;
  final List albumImage;
  final int initialIndex;

  AlbumImageProvider({ required this.albumImage, this.initialIndex = 0 });

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    String? localImagePath = albumImage[index].photoUrl;
    File? imageFile;

    if (localImagePath != null) {
      imageFile = File(localImagePath);
    }

    ImageProvider imageProvider = imageFile != null ?
    Image.network(albumImage[index].photoUrl.toString()).image : AssetImage(Images.placeholder) as ImageProvider;


    return imageProvider;
  }


  @override
  int get imageCount => albumImage.length;
}