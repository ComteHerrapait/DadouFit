import 'dart:developer';

import 'package:dadoufit/l10n/app_localizations.dart';
import 'package:dadoufit/src/js/javascript.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PersistedSettings {
  darkMode(key: "darkmode_enabled"),
  locale(key: "locale"),
  color(key: "theme_seed_color");

  const PersistedSettings({required this.key});
  final String key;
}

class SettingsProvider extends ChangeNotifier {
  late final SharedPreferences prefs;
  final js = Javascript();

  ThemeMode themeMode = ThemeMode.dark;
  Color color = Color.fromARGB(125, 255, 50, 255);
  Locale? locale; // null -> automatic detection

  SettingsProvider() {
    _init();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();

    _loadDarkModeFromPrefs();
    _loadLocaleFromPrefs();
    _loadColorFromPrefs();

    notifyListeners();
  }

  // Load data from persisted preferences

  void _loadDarkModeFromPrefs() {
    bool? isDarkTheme = prefs.getBool(PersistedSettings.darkMode.key);
    if (isDarkTheme != null && isDarkTheme) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  void _loadLocaleFromPrefs() {
    String? localeId = prefs.getString(PersistedSettings.locale.key);
    if (localeId != null && localeId.isNotEmpty) {
      Locale fromPrefs = Locale(localeId);
      if (AppLocalizations.supportedLocales.contains(fromPrefs)) {
        locale = fromPrefs;
        return;
      } else {
        log("Unauthaurozed locale: $localeId");
      }
    }
    locale = null;
    prefs.remove(PersistedSettings.locale.key);
  }

  void _loadColorFromPrefs() {
    String? colorHex = prefs.getString(PersistedSettings.color.key);
    if (colorHex != null && colorHex.isNotEmpty) {
      // Load color from an HEX string
      Color fromPrefs = Color(int.parse(colorHex, radix: 16));
      color = fromPrefs;
    }
  }

  // Public methods to change preferences values

  void changeTheme(ThemeMode newTheme) async {
    themeMode = newTheme;
    prefs.setBool(PersistedSettings.darkMode.key, themeMode == ThemeMode.dark);
    notifyListeners();
  }

  void changeColor(Color newColor) async {
    color = newColor;
    js.setMetaThemeColor(theme().primaryColor);
    prefs.setString(PersistedSettings.color.key, newColor.toHexString());
    notifyListeners();
  }

  void changeLocale(Locale? newLocale) async {
    locale = newLocale;
    if (newLocale != null) {
      prefs.setString(PersistedSettings.locale.key, newLocale.toLanguageTag());
    } else {
      prefs.remove(PersistedSettings.locale.key);
    }
    notifyListeners();
  }

  // Public getters to read preferences values

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
}
