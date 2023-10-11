import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class MyProfileRepo extends GetxService {
  final ApiClient apiClient;

  MyProfileRepo({required this.apiClient,});

  Future<Response> getProfileData() async {
    return await apiClient.postData(AppConstants.GET_PROFILE,{});
  }

  // Future<Response> uploadProfileImage(String userId,XFile image) async {
  //   return await apiClient.postMultipartData(AppConstants.UPLOAD_PROFILE_IMAGE, {"user_id": userId},image.path);
  // }

  Future<Response> updateProfileData(String name, String businessName, String phoneNumber, String email, String city, String address, String bio) async {
    return await apiClient.postData(
      AppConstants.UPDATE_PROFILE,
      {"name": name,
        "business_name": businessName,
        "city": city,
        "address": address,
        "mobile_no": phoneNumber,
        "alt_mobile_no": phoneNumber,
        "email":email,
      },);
  }


  // Future<Response> getFaqList() async {
  //   return await apiClient.postData(AppConstants.FAQ, {});
  // }
  //
  // Future<Response> getReferFaqList() async {
  //   return await apiClient.postData(AppConstants.REFER_FAQ, {});
  // }
  //
  // Future<Response> getLegalPolicies() async {
  //   return await apiClient.postData(AppConstants.LEGAL_POLICIES, {});
  // }
  //
  // Future<Response> getTermsConditions() async {
  //   return await apiClient.postData(AppConstants.TERMS_CONDITION, {});
  // }


}
