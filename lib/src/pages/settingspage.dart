import 'package:dadoufit/src/providers/themeprovider.dart';
import 'package:dadoufit/src/utils/ContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

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
              onPressed:
                  () => showDialog<String>(
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
