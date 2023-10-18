import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class HomeRepo extends GetxService {
  final ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER_LIST);
  }

  Future<Response> getPDFFile() async {
    return await apiClient.getData(AppConstants.PDF_URI,);
  }
}
