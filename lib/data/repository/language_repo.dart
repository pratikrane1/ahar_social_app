import 'package:aharconnect/data/model/language_model.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstants.languages;
  }
}
