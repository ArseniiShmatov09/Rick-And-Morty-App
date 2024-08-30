import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _themeMode = ThemeMode.system;

  void _onThemeChanged(ThemeMode? mode) {
    if (mode != null) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(48, 27, 40, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Color.fromRGBO(221, 197, 162, 1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.brightness_6, color: Colors.black, size: 28),
                          SizedBox(width: 10),
                          Text(
                            'Выберите тему',
                            style: TextStyle(
                              fontSize: 26, 
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      RadioListTile<ThemeMode>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Светлая',
                          style: TextStyle(fontSize: 20), 
                        ),
                        value: ThemeMode.light,
                        groupValue: _themeMode,
                        onChanged: _onThemeChanged,
                      ),
                      RadioListTile<ThemeMode>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Тёмная',
                          style: TextStyle(fontSize: 20), 
                        ),
                        value: ThemeMode.dark,
                        groupValue: _themeMode,
                        onChanged: _onThemeChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
