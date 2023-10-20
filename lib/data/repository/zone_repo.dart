import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class ZoneRepo extends GetxService {
  final ApiClient apiClient;
  ZoneRepo({required this.apiClient});

  Future<Response> getZoneList() async {
    return await apiClient.getData(
      AppConstants.ZONE_LIST,
    );
  }

  Future<Response> getMembersList(String zoneId) async {
    return await apiClient
        .postData(AppConstants.GET_MEMBERS_LIST, {"zone_id": zoneId});
  }

  Future<Response> getPostDataList(String zoneId, String type) async {
    return await apiClient.postData(AppConstants.POST_DATA_LIST, {
      "zone_id": zoneId,
      "type": type,
    });
  }

  Future<Response> getPostLike(String postId,String type) async {
    return await apiClient.postData(AppConstants.POST_LIKE, {
      "post_id": postId,
      "type": type
    });
  }

  Future<Response> addPostLike(String postId, String isLike) async {
    return await apiClient.postData(AppConstants.POST_LIKE_DISLIKE, {
      "post_id": postId,
      "is_like": isLike,
    });
  }

  Future<Response> addCommentLike(String commentId, String isLike) async {
    return await apiClient.postData(AppConstants.COMMENT_LIKE, {
      "comment_id": commentId,
      "is_like": isLike,
    });
  }

  Future<Response> deletePost(String postId) async {
    return await apiClient.getData(AppConstants.DELETE_POST+"/$postId",);
  }

  Future<Response> getPostComment(String postId,) async {
    return await apiClient.postData(AppConstants.GET_POST_COMMENT, {
      "post_id": postId,
    });
  }

  Future<Response> postComment(String commentableId,String userId,String commentabeType,String desc) async {
    return await apiClient.postData(AppConstants.POST_COMMENT, {
      "commentable_id":commentableId,
      "user_id":userId,
      "commentable_type":commentabeType,
      "dsc":desc,
    });
  }

  Future<Response> getPostData(String zoneId, String postId) async {
    return await apiClient.postData(AppConstants.POST_DETAIL, {
      "zone_id": zoneId,
      "post_id": postId,
    });
  }
}
