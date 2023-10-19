import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(
      {String? phone,
      String? token,
      String? deviceId,
      String? password,
      String? loginwith}) async {
    return await apiClient.postData(AppConstants.LOGIN, {
      "mobile_no": phone,
    });
  }

  Future<Response> verifyOTP(
      {String? userId, String? otp, String? fcmToken}) async {
    return await apiClient.postData(AppConstants.VERIFY_OTP, {
      "user_id": userId,
      "otp": otp,
      "fcm_token" : fcmToken,
    });
  }

  Future<Response> updateFirebaseFCM(String fcmToken) async {

    return await apiClient.postData("${AppConstants.UPDATE_FCM}?fcm_token=$fcmToken", {});
  }

// for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
      token,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE).toString(),
    );
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  Future<void> saveUserNumber(String number) async {
    try {
      await sharedPreferences.setString(
          AppConstants.USER_NUMBER, number.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserRole(String role) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_ROLE, role.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveNumberTemporary(String number) async {
    try {
      await sharedPreferences.setString(
          AppConstants.NUMBER_TEMPORARY, number.trim());
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserId(int id) async {
    try {
      await sharedPreferences.setInt(AppConstants.USER_ID, id);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveReferalCode(String referalCode) async {
    try {
      await sharedPreferences.setString(AppConstants.REFERAL_CODE, referalCode);
    } catch (e) {
      throw e;
    }
  }

  int getUserId() {
    return sharedPreferences.getInt(AppConstants.USER_ID) ?? 0;
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserRole() {
    return sharedPreferences.getString(AppConstants.USER_ROLE) ?? "";
  }

  String getNumberTemporary() {
    return sharedPreferences.getString(AppConstants.NUMBER_TEMPORARY) ?? "";
  }

  Future<bool> clearUserNumber() async {
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  Future<bool> clearToken() async {
    return await sharedPreferences.remove(AppConstants.TOKEN);
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  Future<void> setNotificationActive(bool isActive) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    if (isActive) {
      updateFirebaseFCM(fcmToken.toString(),);
    } else {
      updateFirebaseFCM("");
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }
}
