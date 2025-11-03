import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeController() {
    loadTheme();
  }

  void toggleTheme(bool value) {
    _isDarkMode = value;
    saveTheme(value);
    notifyListeners();
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }
}
