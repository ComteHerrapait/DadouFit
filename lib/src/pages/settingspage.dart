import 'package:dadoufit/src/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
          Center(child: const Text("Settings")),
          ListTile(
            title: const Text("DarkMode"),
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
            title: Text("Color"),
            trailing: ElevatedButton(
              child: const Text('Pick Color'),
              onPressed:
                  () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => ColorPicker(),
                  ),
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
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
