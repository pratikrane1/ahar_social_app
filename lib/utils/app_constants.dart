import 'package:socialrecipe/src/language_model.dart';

import 'images.dart';

class AppConstants {
  static const String APP_VERSION = "1.0.0+1";

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
