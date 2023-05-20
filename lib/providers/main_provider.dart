import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  Locale locale = const Locale('en');
  ThemeMode themeMode = ThemeMode.dark;

  void changeLanguage(String local) {
    locale = Locale(local);
    notifyListeners();
  }

  void changeThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }
}
