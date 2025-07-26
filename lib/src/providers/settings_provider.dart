import 'package:dadoufit/src/js/javascript.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  Color color = Color.fromARGB(125, 255, 50, 255);
  Locale? locale; // null -> automatic detection
  final js = Javascript();

  SettingsProvider() {
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

  void changeColor(Color newColor) async {
    color = newColor;
    js.setMetaThemeColor(theme().primaryColor);
    notifyListeners();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;
  Brightness get brightness =>
      themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: color,
      ),
    );
  }

  void changeLocale(Locale? newLocale) async {
    locale = newLocale;
    notifyListeners();
  }
}
