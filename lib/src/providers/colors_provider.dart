import 'package:flutter/material.dart';

import 'settings_provider.dart';

class ColorsProvider {
  final SettingsProvider settingsProvider;

  ColorsProvider(this.settingsProvider);

  bool get isDarkMode => settingsProvider.isDarkMode;
  bool get isColorblind => settingsProvider.isColorblind;

  static const Color colorblindOrange = Color.fromARGB(255, 255, 194, 10);
  static const Color colorblindBlue = Color.fromARGB(255, 12, 123, 220);

  Color colorAvailableForeground() =>
      isColorblind ? colorblindOrange : Colors.green;

  Color colorAvailableBackground() =>
      isColorblind ? colorblindOrange : Colors.green;

  Color colorUnavailableForeground() =>
      isColorblind ? colorblindBlue : Colors.red;

  Color colorUnavailableBackground() =>
      isColorblind ? Colors.grey : Colors.grey;
}
