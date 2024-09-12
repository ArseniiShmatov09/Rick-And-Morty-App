import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../bloc/theme/theme_state.dart';

class ThemeSelectionCardWidget extends StatelessWidget {
  const ThemeSelectionCardWidget({super.key});

  void _onThemeChanged(BuildContext context, Brightness? brightness) {
    if (brightness != null) {
      context.read<ThemeCubit>().setThemeBrightness(brightness);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: const Color.fromARGB(222, 185, 184, 184),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.brightness_6,
                    color: Colors.black,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Choose a theme',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      RadioListTile<Brightness>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Light',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: Brightness.light,
                        groupValue: state.brightness,
                        onChanged: (brightness) =>
                            _onThemeChanged(context, brightness),
                      ),
                      RadioListTile<Brightness>(
                        activeColor: Colors.black,
                        title: const Text(
                          'Dark',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: Brightness.dark,
                        groupValue: state.brightness,
                        onChanged: (brightness) =>
                            _onThemeChanged(context, brightness),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
