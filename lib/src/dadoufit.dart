import 'package:dadoufit/l10n/app_localizations.dart';
import 'package:dadoufit/src/pages/mainpage.dart';
import 'package:dadoufit/src/pages/settingspage.dart';
import 'package:dadoufit/src/pages/welcomepage.dart';
import 'package:dadoufit/src/pages/wrapper.dart';
import 'package:dadoufit/src/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DadouFitApp extends StatelessWidget {
  const DadouFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (context) {
            final themeProvider = Provider.of<SettingsProvider>(context);
            final settingsProvider = Provider.of<SettingsProvider>(context);

            return MaterialApp(
              title: 'DadouFit',
              theme: themeProvider.theme(),
              home: const Wrapper(
                welcomepage: WelcomePage(),
                mainpage: MainPage(),
                settingspage: SettingsPage(),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: settingsProvider.locale,
            );
          },
        ),
      ),
    );
  }
}
