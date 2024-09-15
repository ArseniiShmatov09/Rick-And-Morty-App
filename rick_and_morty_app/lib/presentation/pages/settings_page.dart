import 'package:flutter/material.dart';
import '../widgets/theme_selection_card_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ThemeSelectionCardWidget(),
        ),
      ),
    );
  }
}
