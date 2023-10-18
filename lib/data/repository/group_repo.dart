import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class GroupRepo extends GetxService {
  final ApiClient apiClient;
  GroupRepo({required this.apiClient});

  Future<Response> getOfficeBearersList() async {
    return await apiClient.postData(AppConstants.OFFICE_BEARERS, {});
  }

  Future<Response> getSubCommitteeList() async {
    return await apiClient.postData(AppConstants.SUB_COMMITTEE, {});
  }
}
