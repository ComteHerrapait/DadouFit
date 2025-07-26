import 'package:dadoufit/src/dadoufit.dart';
import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';

Future<void> main() async {
  PWAInstall().setup(
    installCallback: () {
      debugPrint('APP INSTALLED!');
    },
  );

  runApp(const DadouFitApp());
}
