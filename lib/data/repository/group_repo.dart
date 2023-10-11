import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class GroupRepo extends GetxService {
  final ApiClient apiClient;
  GroupRepo({required this.apiClient});

  Future<Response> getZoneList() async {
    return await apiClient
        .getData(AppConstants.ZONE_LIST,);
  }
}
