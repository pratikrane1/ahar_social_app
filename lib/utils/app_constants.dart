import 'package:socialrecipe/src/language_model.dart';

import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Ahar Connect';
  static const String APP_VERSION = "1.0.0+1";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static const String BASE_URL = 'http://ahar.ezii.live/api';

  static const String LOGIN = '/login';
  static const String VERIFY_OTP = '/otp-verification';
  static const String ZONE_LIST = '/get-user-zone';
  static const String GET_PROFILE = '/get-profile';
  static const String UPDATE_PROFILE = '/update-profile';


  //Shared Key
  static const String TOKEN = 'token';
  static const String USER_NUMBER = 'user_number';
  static const String NUMBER_TEMPORARY = 'number_temporary';
  static const String USER_ID = 'user_id';
  static const String REFERAL_CODE = 'referal_code';
  static const String PROFILE_DATA = 'profile_data';
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static const String LOCALIZATION_KEY = 'language';
  static const String NOTIFICATION = 'notification';

  //paymenet gateway key
  static const String RAZORPAY_KEY = 'rzp_live_YPqi3Ls1a4tYhP';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    // LanguageModel(
    //     imageUrl: Images.hindi,
    //     languageName: 'Hindi',
    //     countryCode: 'IN',
    //     languageCode: 'hi'),
    // LanguageModel(
    //     imageUrl: Images.marathi,
    //     languageName: 'Marathi',
    //     countryCode: 'IN',
    //     languageCode: 'mr'),
  ];
}
