import 'package:dadoufit/src/pages/mainpage.dart';
import 'package:dadoufit/src/pages/settingspage.dart';
import 'package:dadoufit/src/pages/welcomepage.dart';
import 'package:dadoufit/src/pages/wrapper.dart';
import 'package:dadoufit/src/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DadouFitApp extends StatelessWidget {
  const DadouFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (context) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              title: 'DadouFit',
              theme: themeProvider.theme(),
              home: const Wrapper(
                welcomepage: WelcomePage(),
                mainpage: MainPage(),
                settingspage: SettingsPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
