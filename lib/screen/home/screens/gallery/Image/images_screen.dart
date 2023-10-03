// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:socialrecipe/utils/theme_colors.dart';
// import 'package:socialrecipe/widget/custom_image.dart';
//
// import 'like_user_screen.dart';
//
// class ImagesScreen extends StatefulWidget {
//   AlbumModel? albumData;
//   ImagesScreen({Key? key,required this.albumData}) : super(key: key);
//
//   @override
//   State<ImagesScreen> createState() => _ImagesScreenState();
// }
//
// class _ImagesScreenState extends State<ImagesScreen> {
//
//   List<AlbumImagesModel>? _albumImagesList;
//   bool _isAlbumImages = false;
//   bool _isLike = false;
//
//   @override
//   void initState(){
//     super.initState();
//     // Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ThemeColors.whiteColor,
//         title: Text(
//           widget.albumData!.albumName ?? "",
//           maxLines: 2,
//           style: Theme.of(context).textTheme.headline6!.copyWith(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             fontFamily: 'Montserrat',
//           ),
//         ),
//         leading: IconButton(
//           splashRadius: 20,
//           onPressed: () async {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: 24,
//           ),
//         ),
//         centerTitle: false,
//         elevation: 3.0,
//         bottomOpacity: 0.0,
//       ),
//       body: RefreshIndicator(
//         color: ThemeColors.primaryColor,
//         onRefresh: ()async{
//           // await Get.find<GalleryController>().getAlbumImages(widget.albumData!.id.toString(),Get.find<AuthController>().getUserId().toString(),false);
//         },
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: MasonryGridView.count(
//                     itemCount: _albumImagesList!.length,
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 4,
//                     crossAxisSpacing: 4,
//                     itemBuilder:(context, index) {
//                       return Column(
//                         children: [
//                           GestureDetector(
//                             onTap: (){
//                               // Get.to(() => ImageViewerScreen(albumImage: _albumImagesList!,initialIndex: index,albumData: widget.albumData!,));
//                             },
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                   color: Colors.transparent,
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(15))
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(15)),
//                                 child: CustomImage(
//                                   image: "",
//                                   fit: BoxFit.cover,
//                                   // width: MediaQuery.of(context).size.width,
//                                   // height: 200,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 6.0,right: 6.0,bottom: 10.0,top: 5.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children:  [
//                                 Row(
//                                   children: [
//
//                                     InkWell(
//                                         onTap: (){
//                                           if(_albumImagesList![index].isLike == "1"){
//                                             // Get.find<GalleryController>().setLikeUnlikePhoto(Get.find<AuthController>().getUserId(),
//                                             //     widget.albumData!.id.toString(),_albumImagesList![index].id.toString(),0.toString());
//                                           }else{
//                                             // Get.find<GalleryController>().setLikeUnlikePhoto(Get.find<AuthController>().getUserId(),
//                                             //     widget.albumData!.id.toString(),_albumImagesList![index].id.toString(),1.toString());
//                                           }
//                                         },
//                                         child: Icon(_albumImagesList![index].isLike != "1" ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
//                                             color:_albumImagesList![index].isLike == "1" ? ThemeColors.redColor : null,
//                                             size: 20)),
//                                     const SizedBox(width: 4,),
//                                     InkWell(
//                                       onTap: (){
//                                         _albumImagesList![index].likeCount != 0 ?
//                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                                             LikeUserListScreen(photoId: _albumImagesList![index].id.toString(),))) : null;
//                                       },
//                                       child: Text(_albumImagesList![index].likeCount != 0 ?
//                                       "${_albumImagesList![index].likeCount} ${_albumImagesList![index].likeCount == 1 ? "Like" : "Likes"}" : "",
//                                         style:const TextStyle(
//                                             decoration: TextDecoration.underline,
//                                             fontSize: 13,
//                                             color: ThemeColors.blackColor,
//                                             fontFamily: 'Montserrat',
//                                             fontWeight: FontWeight.w500),),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: (){
//                                         Get.find<GalleryController>().shareImage(_albumImagesList![index].photoUrl!,
//                                             _albumImagesList![index],widget.albumData!);
//                                       },
//                                       child: SvgPicture.asset(
//                                         Images.share_icon,
//                                         height: 20,
//                                       ),),
//                                     const SizedBox(width: 2,),
//                                     _albumImagesList![index].totalShare != 0 ?
//                                     Text("(${_albumImagesList![index].totalShare ?? 0})",
//                                       style:const TextStyle(
//                                           fontSize: 13,
//                                           color: ThemeColors.blackColor,
//                                           fontFamily: 'Montserrat',
//                                           fontWeight: FontWeight.w500),
//                                     ) : Container(),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       );
//                     }
//                 ),
//               ),
//             )
//
//           ],
//         )
//         ),
//       ),
//     );
//   }
// }
//
// class AlbumImageProvider extends EasyImageProvider {
//
//   final List<AlbumImagesModel> albumImage;
//   final int initialIndex;
//
//   AlbumImageProvider({ required this.albumImage, this.initialIndex = 0 });
//
//   @override
//   ImageProvider<Object> imageBuilder(BuildContext context, int index) {
//     String? localImagePath = albumImage[index].photoUrl;
//     File? imageFile;
//
//     if (localImagePath != null) {
//       imageFile = File(localImagePath);
//     }
//
//     ImageProvider imageProvider = imageFile != null ?
//     Image.network(albumImage[index].photoUrl.toString()).image : AssetImage(Images.placeholder) as ImageProvider;
//
//
//     return imageProvider;
//   }
//
//
//   @override
//   int get imageCount => albumImage.length;
// }