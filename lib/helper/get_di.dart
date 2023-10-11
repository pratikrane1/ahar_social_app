import 'dart:convert';
import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/localization_controller.dart';
import 'package:aharconnect/controller/profile_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/data/model/language_model.dart';
import 'package:aharconnect/data/repository/auth_repo.dart';
import 'package:aharconnect/data/repository/language_repo.dart';
import 'package:aharconnect/data/repository/profile_repo.dart';
import 'package:aharconnect/data/repository/zone_repo.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<Map<String, Map<String, String>>>  init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ZoneRepo(apiClient: Get.find()));
  Get.lazyPut(() => MyProfileRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => ZoneController(zoneRepo: Get.find()));
  Get.lazyPut(() => MyProfileController(myProfileRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}