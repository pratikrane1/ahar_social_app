import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/data/model/response_model.dart';
import 'package:aharconnect/data/repository/profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'auth_controller.dart';

class MyProfileController extends GetxController implements GetxService {
  final MyProfileRepo myProfileRepo;
  MyProfileController({required this.myProfileRepo});

  bool _isLoading = false;
  Profile? _profileData;
  String? _updateProfileMessage;



  bool get isLoading => _isLoading;
  Profile? get profileData => _profileData;
  String get updateProfileMessage => _updateProfileMessage!;


  Future<Profile> getProfileData() async {
    Response response = await myProfileRepo.getProfileData();
    if (response.statusCode == 200) {
      _profileData = Profile.fromJson(response.body!["data"]);
      print(_profileData);
      update();
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _profileData!;
    // }
  }

  Future<ResponseModel> updateProfileData(String name, String businessName, String phoneNumber, String email, String city, String address, String bio) async {
    _isLoading = false;
    ResponseModel? _responseModel;
    Response response = await myProfileRepo.updateProfileData(name, businessName, phoneNumber,email , city , address, bio);
    if (response.statusCode == 200) {
      getProfileData();
      _updateProfileMessage = response.body!["message"];
      _responseModel = ResponseModel(true, response.bodyString.toString(),1);
      update();
      print(_updateProfileMessage);
      _isLoading = true;
    } else {
      _responseModel = ResponseModel(false, response.statusText.toString(),0);
      print(response.statusText);
      ApiChecker.checkApi(response);
      _isLoading = true;
    }
    update();
    return _responseModel;
  }

}
