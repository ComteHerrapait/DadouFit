import 'package:dadoufit/src/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

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
                    builder:
                        (BuildContext context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialPicker(
                                  pickerColor: pickerColor,
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
                        ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
