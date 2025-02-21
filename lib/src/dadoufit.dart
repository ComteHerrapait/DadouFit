import 'package:dadoufit/src/pages/settingspage.dart';
import 'package:dadoufit/src/pages/welcomepage.dart';
import 'package:dadoufit/src/pages/mainpage.dart';
import 'package:dadoufit/src/pages/wrapper.dart';
import 'package:flutter/material.dart';

class DadouFitApp extends StatelessWidget {
  const DadouFitApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        title: 'DadouFit',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(125, 255, 50, 255),
          ),
        ),
        home: const Wrapper(
          welcomepage: WelcomePage(),
          mainpage: MainPage(),
          settingspage: SettingsPage(),
        ),
      ),
    );
  }
}
