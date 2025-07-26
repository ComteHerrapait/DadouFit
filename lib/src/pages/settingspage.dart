import 'package:dadoufit/l10n/app_localizations.dart';
import 'package:dadoufit/src/providers/settings_provider.dart';
import 'package:dadoufit/src/utils/build_context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pwa_install/pwa_install.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final pwa = PWAInstall();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: Text(context.translations.settingsTitle)),
          ListTile(
            title: Text(context.translations.settingsDarkMode),
            trailing: Checkbox(
              value: settingsProvider.isDarkMode,
              onChanged: (v) {
                if (v == null) return;
                settingsProvider.changeTheme(
                  v ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),
          ListTile(
            title: Text(context.translations.settingsColor),
            trailing: ElevatedButton(
              child: Text(context.translations.settingsColorPick),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => ColorPicker(),
              ),
            ),
          ),
          ListTile(
            title: Text(context.translations.settingsLocale),
            trailing: DropdownButton<Locale?>(
              value: settingsProvider.locale,
              items: [
                DropdownMenuItem<Locale?>(
                  value: null,
                  child: Text(context.translations.defaultValue),
                ),
                ...AppLocalizations.supportedLocales.map((locale) {
                  return DropdownMenuItem<Locale?>(
                    value: locale,
                    child: Text(locale.languageCode.toUpperCase()),
                  );
                }),
              ],
              onChanged: settingsProvider.changeLocale,
            ),
          ),
          if (kIsWeb)
            ListTile(
              title: Text(context.translations.settingsPwaInstall),
              trailing: pwa.installPromptEnabled
                  ? IconButton(
                      onPressed: () => pwa.promptInstall_(),
                      icon: Icon(Icons.add_to_home_screen),
                    )
                  : Icon(Icons.file_download_off),
            ),
          ListTile(
            title: Text(context.translations.settingsVersion),
            trailing: FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, asyncSnapshot) {
                return Text(asyncSnapshot.data?.version ?? "Unknown");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialPicker(
              pickerColor: settingsProvider.color,
              onColorChanged: settingsProvider.changeColor,
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.translations.close),
            ),
          ],
        ),
      ),
    );
  }
}
