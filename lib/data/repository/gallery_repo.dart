
import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class GalleryRepo extends GetxService {
  final ApiClient apiClient;
  GalleryRepo({required this.apiClient});

  Future<Response> getAlbumList() async {
    return await apiClient
        .getData(AppConstants.ALBUM,);
  }

  Future<Response> getAlbumImagesList(String albumId,) async {
    return await apiClient
        .postData(AppConstants.ALBUM_IMAGES,{
          "id" : albumId,
    });
  }
  //
  // Future<Response> setLikeUnlikePhoto(String userId,String albumID,String photoId,String isLike) async {
  //   return await apiClient
  //       .postData(AppConstants.LIKE_ALBUM_IMAGES,{
  //         "user_id" : userId,
  //         "album_id" : albumID,
  //         "photo_id" : photoId,
  //         "is_like" : isLike
  //   });
  // }
  //
  // Future<Response> getLikedUserList(String photoId) async {
  //   return await apiClient
  //       .postData(AppConstants.IMAGE_LIKED_USER_LIST,{
  //     "photo_id" : photoId,
  //   });
  // }
  //
  // Future<Response> sharePhoto(String userId,String albumID,String photoId,String isShare) async {
  //   return await apiClient
  //       .postData(AppConstants.SHARE_ALBUM_IMAGES,{
  //     "user_id" : userId,
  //     "album_id" : albumID,
  //     "photo_id" : photoId,
  //     "is_share" : isShare
  //   });
  // }
  //
  // Future<Response> getVideoList() async {
  //   return await apiClient
  //       .postData(AppConstants.VIDEOS,{});
  // }
}
