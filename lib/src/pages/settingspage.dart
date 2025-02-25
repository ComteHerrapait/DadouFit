import 'package:dadoufit/src/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool booleanValue = false;

  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('booleanValue') != null) {
      setState(() {
        booleanValue = prefs.getBool('booleanValue')!;
      });
    }
  }

  void _updateThemeBoolean(bool? newValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (newValue == null) {
      setState(() {
        prefs.remove('booleanValue');
      });
    }
    setState(() {
      booleanValue = newValue!;
      prefs.setBool('booleanValue', booleanValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: const Text("SettingsPage")),
          ListTile(
            title: const Text("DarkMode"),
            trailing: Checkbox(
              value: booleanValue,
              onChanged: (v) {
                if (v == null) return;
                themeProvider.changeTheme(v ? ThemeMode.dark : ThemeMode.light);
                _updateThemeBoolean(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
