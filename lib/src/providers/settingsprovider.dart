import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  Brightness get brightness =>
      themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;

  ThemeProvider() {
    _init();
  }

  void _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDarkTheme = sharedPreferences.getBool("is_dark");
    if (isDarkTheme != null && isDarkTheme) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    themeMode = newTheme;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_dark", themeMode == ThemeMode.dark);
    notifyListeners();
  }

  ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: themeMode  == ThemeMode.dark ? Brightness.dark : Brightness.light,
        seedColor: const Color.fromARGB(125, 255, 50, 255),
      ),
    );
  }
}
