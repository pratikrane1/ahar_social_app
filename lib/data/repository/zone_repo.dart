import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class ZoneRepo extends GetxService {
  final ApiClient apiClient;
  ZoneRepo({required this.apiClient});

  Future<Response> getZoneList() async {
    return await apiClient
        .getData(AppConstants.ZONE_LIST,);
  }
}
