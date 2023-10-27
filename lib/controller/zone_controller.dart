import 'dart:io';

import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/comment_model.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/data/repository/zone_repo.dart';
import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';

import 'gallery_controller.dart';

class ZoneController extends GetxController implements GetxService {
  final ZoneRepo zoneRepo;
  ZoneController({required this.zoneRepo});

  bool _isLoading = false;
  bool _isPostDataLoading = false;
  bool _isMemberLoading = false;
  List<ZoneModel>? _zoneList;
  List<PostData>? _postDataList;
  List<PostData>? _homePostDataList;
  List<PostData>? _homeNoticeBoardDataList;
  List<FeedPostLike>? _postLikeList;
  List<CommentModel>? _postCommentList;
  List<PostData>? _noticePostDataList;
  List<MemberModel>? _membersList;

  bool get isLoading => _isLoading;
  bool get isPostDataLoading => _isPostDataLoading;
  bool get isMemberLoading => _isMemberLoading;
  List<ZoneModel>? get zoneList => _zoneList;
  List<PostData>? get postDataList => _postDataList;
  List<PostData>? get homeNoticeBoardDataList => _homeNoticeBoardDataList;
  List<PostData>? get homePostDataList => _homePostDataList;
  List<CommentModel>? get postCommentList => _postCommentList;
  List<FeedPostLike>? get postLikeList => _postLikeList;
  List<PostData>? get noticePostDataList => _noticePostDataList;
  List<MemberModel>? get membersList => _membersList;

  Future<List<ZoneModel>> getZoneList(bool fromGroup) async {
    _isLoading = false;
    if(fromGroup){
      _zoneList = [];
    }
    Response response = await zoneRepo.getZoneList();
    if (response.statusCode == 200) {
      final Iterable refactorZoneList = response.body!["data"] ?? [];
      _zoneList = refactorZoneList.map((item) {
        return ZoneModel.fromJson(item);
      }).toList();
      _zoneList!.sort((a, b) {
        return a.id!.compareTo(b.id!);
      });
      if(fromGroup){
        _zoneList!.removeAt(0);
      }
      print(_zoneList);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _zoneList!;
  }

  Future<List<MemberModel>> getMembersList(String zoneId) async {
    _isMemberLoading = false;
    Response response = await zoneRepo.getMembersList(zoneId);
    if (response.statusCode == 200) {
      final Iterable refactorZoneList = response.body!["data"] ?? [];
      _membersList = refactorZoneList.map((item) {
        return MemberModel.fromJson(item);
      }).toList();
      print(_membersList);
      _isMemberLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _membersList!;
  }

  Future<List<PostData>> getFeedPostDataList(String zoneId, String type) async {
    _isPostDataLoading = false;
    // _postDataList = [];
    Response response = await zoneRepo.getPostDataList(zoneId, type);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _postDataList = refactorPostDataList.map((item) {
        return PostData.fromJson(item);
      }).toList();
      print(_postDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postDataList!;
  }

  Future<List<PostData>> getNoticePostList(String zoneId, String type) async {
    _isPostDataLoading = false;
    // _noticePostDataList = [];
    Response response = await zoneRepo.getPostDataList(zoneId, type);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _noticePostDataList = refactorPostDataList.map((item) {
        return PostData.fromJson(item);
      }).toList();
      print(_noticePostDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postDataList!;
  }

  Future<List<PostData>> getHomeFeedPostDataList(String type) async {
    _isPostDataLoading = false;
    // _postDataList = [];
    Response response = await zoneRepo.getHomePostDataList(type);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"][0] ?? [];
      _homePostDataList = refactorPostDataList.map((item) {
        return PostData.fromJson(item);
      }).toList();
      print(_homePostDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _homePostDataList!;
  }

  Future<List<PostData>> getHomeNoticeBoardPostDataList(String type) async {
    _isPostDataLoading = false;
    // _homeNoticeBoardDataList = [];
    Response response = await zoneRepo.getHomePostDataList(type);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"][0] ?? [];
      _homeNoticeBoardDataList = refactorPostDataList.map((item) {
        return PostData.fromJson(item);
      }).toList();
      print(_homeNoticeBoardDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _homeNoticeBoardDataList!;
  }


  Future<List<FeedPostLike>> getPostLike(String postId,String type) async {
    // _noticePostDataList = [];
    _postLikeList = [];
    Response response = await zoneRepo.getPostLike(postId,type);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _postLikeList = refactorPostDataList.map((item) {
        return FeedPostLike.fromJson(item);
      }).toList();
      print(_postLikeList);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postLikeList!;
  }

  Future<List<CommentModel>> getPostComment(String postId,bool fromFeed) async {
    if(fromFeed){
      _postCommentList = [];
    }
    Response response = await zoneRepo.getPostComment(postId,);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _postCommentList = refactorPostDataList.map((item) {
        return CommentModel.fromJson(item);
      }).toList();
      print(_postCommentList);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postCommentList!;
  }


  Future PostComment(String commentableId,String userId,String commentabeType,String desc,String postId) async {
    Response response = await zoneRepo.postComment(commentableId,userId,commentabeType,desc);
    if (response.statusCode == 200) {
      final refactorPostDataList = response.body!["data"] ?? [];
      getPostComment(postId,false);
      print(refactorPostDataList);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<bool> addPostLike(
      String postId, String isLike, String zoneId, String type,bool fromGalary,String albumId) async {
    Response response = await zoneRepo.addPostLike(postId, isLike);
    if (response.statusCode == 200) {
      // final Iterable refactorPostDataList = response.body!["data"] ?? [];
      if(fromGalary) {
        Get.find<GalleryController>().getAlbumImages(albumId, false);
      }else{
        getFeedPostDataList(zoneId, type);
      }
      print(_postDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return response.body["success"]!;
  }

  Future addCommentLike(String commentId, String isLike,String postId) async {
    Response response = await zoneRepo.addCommentLike(commentId, isLike);
    if (response.statusCode == 200) {
      ///Get Comment api call
      getPostComment(postId,false);

      print(_postDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    // return response.body["success"]!;
  }

  Future deletePost(String zoneId, String type,String postId) async {
    Response response = await zoneRepo.deletePost(postId);
    if (response.statusCode == 200) {
      ///Get Comment api call
      getFeedPostDataList(zoneId, type);

      showCustomSnackBar("Post Deleted Successfully.", isError: false);

    } else {
      ApiChecker.checkApi(response);
    }
    update();
    // return response.body["success"]!;
  }


  Future<List<PostData>> getPostDataList(String zoneId, String postId) async {
    _isPostDataLoading = false;
    // _postDataList = [];
    Response response = await zoneRepo.getPostData(zoneId, postId);
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _postDataList = refactorPostDataList.map((item) {
        return PostData.fromJson(item);
      }).toList();
      print(_postDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postDataList!;
  }


  Future downloadPDF(String url) async {
    var fileName = url.split(Platform.pathSeparator).last;

  }
}
