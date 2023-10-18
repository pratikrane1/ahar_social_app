import 'dart:io';

import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/comment_model.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/data/repository/zone_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';

class ZoneController extends GetxController implements GetxService {
  final ZoneRepo zoneRepo;
  ZoneController({required this.zoneRepo});

  bool _isLoading = false;
  bool _isPostDataLoading = false;
  bool _isMemberLoading = false;
  List<ZoneModel>? _zoneList;
  List<PostData>? _postDataList;
  List<FeedPostLike>? _postLikeList;
  List<CommentModel>? _postCommentList;
  List<PostData>? _noticePostDataList;
  List<MemberModel>? _membersList;

  bool get isLoading => _isLoading;
  bool get isPostDataLoading => _isPostDataLoading;
  bool get isMemberLoading => _isMemberLoading;
  List<ZoneModel>? get zoneList => _zoneList;
  List<PostData>? get postDataList => _postDataList;
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

  Future<List<FeedPostLike>> getPostLike(String postId,) async {
    // _noticePostDataList = [];
    _postLikeList = [];
    Response response = await zoneRepo.getPostLike(postId,);
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


  Future<List<PostData>> addPostLike(
      String postId, String isLike, String zoneId, String type) async {
    Response response = await zoneRepo.addPostLike(postId, isLike);
    if (response.statusCode == 200) {
      // final Iterable refactorPostDataList = response.body!["data"] ?? [];
      getFeedPostDataList(zoneId, type);
      print(_postDataList);
      _isPostDataLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _postDataList!;
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
    // var localPath = await getApplicationDocumentsDirectory();
    // await FlutterDownloader.enqueue(
    //   url: url,
    //   headers: {}, // optional: header send with url (auth token etc)
    //   savedDir: localPath.path,
    //   showNotification: true, // show download progress in status bar (for Android)
    //   openFileFromNotification: true,
    //   saveInPublicStorage: true,// click on notification to open downloaded file (for Android)
    // );
    var fileName = url.split(Platform.pathSeparator).last;

    // try {
    //     Directory? directory;
    //     directory = await getExternalStorageDirectory();
    //     String newPath = "";
    //     List<String> paths = directory!.path.split("/");
    //     for (int x = 1; x < paths.length; x++) {
    //       String folder = paths[x];
    //       if (folder != "Android") {
    //         newPath += "/" + folder;
    //       } else {
    //         break;
    //       }
    //     }
    //     newPath = newPath + "/PDF_Download";
    //     directory = Directory(newPath);
    //
    //     File saveFile = File(directory.path + "/$fileName");
    //     if (kDebugMode) {
    //       print(saveFile.path);
    //     }
    //     if (!await directory.exists()) {
    //       await directory.create(recursive: true);
    //     }
    //     if (await directory.exists()) {
    //       await Dio().download(
    //         url,
    //         saveFile.path,
    //       );
    //     }
    //   return true;
    // } catch (e) {
    //   return false;
    // }
  }
}
