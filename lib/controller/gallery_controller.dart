import 'dart:io';

import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/gallery_model.dart';
import 'package:aharconnect/data/repository/gallery_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'auth_controller.dart';

class GalleryController extends GetxController implements GetxService {
  final GalleryRepo galleryRepo;
  GalleryController({required this.galleryRepo});

  bool _isAlbumLoading = false;
  bool _isAlbumImagesLoading = false;
  bool _isVideoLoading = false;
  bool _isLikedImageListLoading = false;
  List<AlbumModel>? _albumList;
  List<AlbumImageModel>? _albumImagesList;
  // List<VideosModel>? _videoList;
  // List<LikedUserList>? _likedUserList;
  int _imageIndex = 0;

  bool get isAlbumLoading => _isAlbumLoading;
  bool get isAlbumImagesLoading => _isAlbumImagesLoading;
  bool get isVideoLoading => _isVideoLoading;
  bool get isLikedImageListLoading => _isLikedImageListLoading;
  List<AlbumModel> get albumList => _albumList ?? [];
  List<AlbumImageModel> get albumImagesList => _albumImagesList ?? [];
  // List<VideosModel> get videoList => _videoList ?? [];
  // List<LikedUserList> get likedUserList => _likedUserList ?? [];
  int get imageIndex => _imageIndex;

  Future<void> getAlbumList() async {
    _isAlbumLoading = false;
    Response response = await galleryRepo.getAlbumList();
    if (response.statusCode == 200) {
      _albumList = [];
      final Iterable refactorProductList = response.body!["data"] ?? [];
      _albumList = refactorProductList.map((item) {
        return AlbumModel.fromJson(item);
      }).toList();
      // _searchProductList!.addAll(Product.fromJson(refactorRocketList));
      print(_albumList);
      _isAlbumLoading = true;
      // Get.find<ProductController>().getTrendingApp();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<List<AlbumImageModel>> getAlbumImages(String albumID,bool fromLike) async {
    if(!fromLike) {
      _isAlbumImagesLoading = false;
    } // _albumImagesList = [];
    Response response = await galleryRepo.getAlbumImagesList(albumID,);
    if (response.statusCode == 200) {
      final Iterable refactorProductList = response.body!["data"] ?? [];
      _albumImagesList = refactorProductList.map((item) {
        return AlbumImageModel.fromJson(item);
      }).toList();
      // _searchProductList!.addAll(Product.fromJson(refactorRocketList));
      print(_albumImagesList);
      update();
      _isAlbumImagesLoading = true;
      // Get.find<ProductController>().getTrendingApp();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _albumImagesList!;
  }
  //
  // Future<ResponseModel> setLikeUnlikePhoto(int userId,String albumID,String photoId,String isLike) async {
  //   ResponseModel? data;
  //   Response response = await galleryRepo.setLikeUnlikePhoto(userId.toString(),albumID,photoId,isLike);
  //   if (response.statusCode == 200) {
  //     final refactorProductList = response.body!;
  //     print(refactorProductList);
  //     // data!.status = response.body!["status"];
  //     data = ResponseModel(true, response.body!["msg"],response.body!["status"]);
  //     getAlbumImages(albumID,userId.toString(),true);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return data!;
  // }
  //
  // Future<List<LikedUserList>> getLikedUserList(String photoId) async {
  //   _isLikedImageListLoading = false;
  //   Response response = await galleryRepo.getLikedUserList(photoId,);
  //   if (response.statusCode == 200) {
  //     final Iterable refactorProductList = response.body!["data"] ?? [];
  //     _likedUserList = refactorProductList.map((item) {
  //       return LikedUserList.fromJson(item);
  //     }).toList();
  //     _isLikedImageListLoading = true;
  //     print(_likedUserList);
  //
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return _likedUserList!;
  // }
  //
  //
  // Future<ResponseModel> shareAlbumPhoto(int userId,String albumID,String photoId,String isShare) async {
  //   ResponseModel? data;
  //   Response response = await galleryRepo.sharePhoto(userId.toString(),albumID,photoId,isShare);
  //   if (response.statusCode == 200) {
  //     final refactorProductList = response.body!;
  //     print(refactorProductList);
  //     // data!.status = response.body!["status"];
  //     data = ResponseModel(true, response.body!["msg"],response.body!["status"]);
  //     getAlbumImages(albumID,userId.toString(),true);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return data!;
  // }
  //
  //
  // Future<List<VideosModel>> getVideos() async {
  //   _isVideoLoading = false;
  //   _videoList = [];
  //   Response response = await galleryRepo.getVideoList();
  //   if (response.statusCode == 200) {
  //
  //     for(int i = 0 ; i < response.body!["data"].length ; i++){
  //       if(response.body!["data"][i]['snippet']["title"] == "EVENT HIGHLIGHTS"){
  //         final Iterable refactorProductList = response.body!["data"][i]["videos"] ?? [];
  //         _videoList = refactorProductList.map((item) {
  //           return VideosModel.fromJson(item);
  //         }).toList();
  //       }
  //     }
  //
  //     print(_videoList);
  //     _isVideoLoading = true;
  //     // Get.find<ProductController>().getTrendingApp();
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return _videoList!;
  // }

  void setImageIndex(int index, bool notify) {
    _imageIndex = index;
    if(notify) {
      update();
    }
  }

  Future<int> shareImage(String imageUrl,AlbumImageModel? albumImagesList,AlbumModel? albumData)async{
    // Get.find<GalleryController>().shareAlbumPhoto(Get.find<AuthController>().getUserId(),
    //     albumData!.id.toString(),albumImagesList!.id.toString(),1.toString());
    final uri = Uri.parse(imageUrl);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path],);
    return 1;
  }

}
