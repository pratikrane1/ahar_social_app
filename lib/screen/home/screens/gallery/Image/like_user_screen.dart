// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// class LikeUserListScreen extends StatefulWidget {
//   String? photoId;
//   LikeUserListScreen({required this.photoId, super.key});
//
//   @override
//   State<LikeUserListScreen> createState() => _LikeUserListScreenState();
// }
//
// class _LikeUserListScreenState extends State<LikeUserListScreen> {
//   List<LikedUserList>? _likedUserList;
//   bool _isLikedImageListLoading = false;
//
//   @override
//   void initState(){
//     super.initState();
//     Get.find<GalleryController>().getLikedUserList(widget.photoId.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ThemeColors.whiteColor,
//         title: Text(
//           "people_who_liked".tr,
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
//       body: GetBuilder<GalleryController>(builder: (galleryController) {
//         _likedUserList = galleryController.likedUserList;
//         _isLikedImageListLoading = galleryController.isLikedImageListLoading;
//           return _isLikedImageListLoading ? SingleChildScrollView(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const ScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               padding: const EdgeInsets.only(
//                   top: 10, bottom: 15, left: 10, right: 10),
//               itemCount: _likedUserList!.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(100)),
//                             // border: Border.all(width: 1),
//                           ),
//                           height: 40,
//                           width: 40,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(100),
//                             child:
//                             _likedUserList![index].profileImage != null
//                                 ? CustomImage(
//                               image: _likedUserList![index].profileImage,
//                               fit: BoxFit.cover,
//                             ) :
//                             SvgPicture.asset(
//                               Images.avtar_icon, height: 25,
//                               // color: ThemeColors.greyTextColor,
//                             ),
//                           )),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Flexible(
//                         child: Text(
//                           _likedUserList![index].userName ?? "",
//                           maxLines: 2,
//                           textAlign: TextAlign.start,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Montserrat',
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           )
//               : Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),);
//         }
//       ),
//
//     );
//   }
// }
