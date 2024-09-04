import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/bloc/theme/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void _onThemeChanged(Brightness? brightness) {

    if (brightness != null) {
      context.read<ThemeCubit>().setThemeBrightness(brightness);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = context.read<ThemeCubit>().state.brightness;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(222, 185, 184, 184),
      ),
      body: Center(
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
                color: Color.fromARGB(222, 185, 184, 184),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.brightness_6,
                              color: Colors.black, size: 28),
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
                      RadioListTile<Brightness>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Светлая',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: Brightness.light,
                        groupValue: brightness,
                        onChanged: _onThemeChanged,
                      ),
                      RadioListTile<Brightness>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Тёмная',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: Brightness.dark,
                        groupValue: brightness,
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
