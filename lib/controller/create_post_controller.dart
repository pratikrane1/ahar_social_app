import 'dart:io';
import 'dart:typed_data';

import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/response_model.dart';
import 'package:aharconnect/data/repository/create_post_repo.dart';
import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

class CreatePostController extends GetxController implements GetxService {
  final CreatePostRepo createPostRepo;
  CreatePostController({required this.createPostRepo});

  bool _isLoading = false;
  XFile? _pickedFile;
  XFile? _pickedFile1;
  Uint8List? _rawFile;
  ImagePicker picker = ImagePicker();

  bool get isLoading => _isLoading;
  XFile get pickedFile => _pickedFile!;
  Uint8List? get rawFile => _rawFile;

  Future<ResponseModel> uploadPost(String userId, String description,
      List zoneList, String type, String docType) async {
    // _pickedFile = null;
    // _rawFile = null;
    ResponseModel? _responseModel;
    Response response = await createPostRepo.uploadPost(
        userId, _pickedFile!, description, zoneList, type, docType);
    if (response.statusCode == 200) {
      _responseModel = ResponseModel(true, response.bodyString.toString(), 1);
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

  Future pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      _pickedFile = XFile(result.files.single.path.toString());
    }
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
          // uploadProfileImage(Get.find<AuthController>().getUserId().toString());
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

  Future pickCameraImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      _pickedFile1 = await compressImage(_pickedFile!);
      _rawFile = await _pickedFile1!.readAsBytes();
      // uploadProfileImage(Get.find<AuthController>().getUserId().toString());
    } else {
      throw Exception('File is not available');
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
