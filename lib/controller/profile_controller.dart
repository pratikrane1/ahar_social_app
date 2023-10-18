import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/profile_model.dart';
import 'package:aharconnect/data/model/response_model.dart';
import 'package:aharconnect/data/repository/profile_repo.dart';
import 'package:aharconnect/widget/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'auth_controller.dart';

class MyProfileController extends GetxController implements GetxService {
  final MyProfileRepo myProfileRepo;
  MyProfileController({required this.myProfileRepo});

  bool _isLoading = false;
  Profile? _profileData;
  String? _updateProfileMessage;
  XFile? _pickedFile;
  XFile? _pickedFile1;
  Uint8List? _rawFile;
  ImagePicker picker = ImagePicker();

  bool get isLoading => _isLoading;
  Profile? get profileData => _profileData;
  String get updateProfileMessage => _updateProfileMessage!;
  XFile get pickedFile => _pickedFile!;
  Uint8List? get rawFile => _rawFile;

  Future<Profile> getProfileData() async {
    _pickedFile = null;
    _rawFile = null;
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

  Future<ResponseModel> updateProfileData(
      String name,
      String businessName,
      String phoneNumber,
      String email,
      String city,
      String address,
      String bio) async {
    _isLoading = false;
    ResponseModel? _responseModel;
    Response response = await myProfileRepo.updateProfileData(
        name, businessName, phoneNumber, email, city, address, bio);
    if (response.statusCode == 200) {
      getProfileData();
      _updateProfileMessage = response.body!["message"];
      _responseModel = ResponseModel(true, response.bodyString.toString(), 1);
      update();
      print(_updateProfileMessage);
      _isLoading = true;
    } else {
      _responseModel = ResponseModel(false, response.statusText.toString(), 0);
      print(response.statusText);
      ApiChecker.checkApi(response);
      _isLoading = true;
    }
    update();
    return _responseModel;
  }

  Future<ResponseModel> uploadProfileImage(
    String userId,
  ) async {
    // _pickedFile = null;
    // _rawFile = null;
    ResponseModel? _responseModel;
    Response response =
        await myProfileRepo.uploadProfileImage(userId, _pickedFile!);
    if (response.statusCode == 200) {
      _responseModel = ResponseModel(true, response.bodyString.toString(), 1);
      getProfileData();
      _pickedFile = null;
      _rawFile = null;
      update();
      _isLoading = true;
      showCustomSnackBar(response.body["message"].toString(), isError: false);
    } else {
      ApiChecker.checkApi(response);
      showCustomSnackBar(response.body["message"].toString(), isError: true);
      _pickedFile = null;
      _rawFile = null;
    }
    update();
    return _responseModel!;
    // }
  }

  Future pickGalleryImage() async {
    try {
      _pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        final bytes = (await _pickedFile!.readAsBytes()).lengthInBytes;
        if (bytes <= 1000000) {
          print("Image Size : ${bytes}");
          _pickedFile1 = await compressImage(_pickedFile!);
          _rawFile = await _pickedFile1!.readAsBytes();
          uploadProfileImage(Get.find<AuthController>().getUserId().toString());
        } else {
          showCustomSnackBar("image_should_be_less_than_1mb".tr, isError: true);
        }
      } else {
        throw Exception('File is not available');
      }
    } catch (e) {
      _pickedFile = null;
      print(e);
    }
    update();
  }

  static Future<XFile> compressImage(XFile file) async {
    final ImageFile _input =
        ImageFile(filePath: file.path, rawBytes: await file.readAsBytes());
    final Configuration _config = Configuration(
      outputType: ImageOutputType.webpThenPng,
      useJpgPngNativeCompressor: false,
      quality: (_input.sizeInBytes / 1048576) < 2
          ? 90
          : (_input.sizeInBytes / 1048576) < 5
              ? 50
              : (_input.sizeInBytes / 1048576) < 10
                  ? 10
                  : 1,
    );
    final ImageFile _output = await compressor
        .compress(ImageFileConfiguration(input: _input, config: _config));
    if (kDebugMode) {
      print('Input size : ${_input.sizeInBytes / 1048576}');
      print('Output size : ${_output.sizeInBytes / 1048576}');
    }
    return XFile.fromData(_output.rawBytes);
  }
}
