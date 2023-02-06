import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  void setDarkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
