import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

class CreatePostRepo extends GetxService {
  final ApiClient apiClient;
  CreatePostRepo({required this.apiClient});

  Future<Response> uploadPost(String userId, XFile image, String description,
      List zoneList, String type, String docType) async {
    print(zoneList);
    return await apiClient.postMultipartData(
        AppConstants.UPLOAD_POST,
        {
          "user_id": userId,
          "dsc": description,
          "zone_id": zoneList.toString(),
          "type": type,
          "doc_type": docType,
        },
        image.path);
  }
}
