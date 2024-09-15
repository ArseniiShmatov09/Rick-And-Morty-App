import 'package:flutter/material.dart';
import '../widgets/theme_selection_card_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(222, 185, 184, 184),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ThemeSelectionCardWidget(),
        ),
      ),
    );
  }
}
