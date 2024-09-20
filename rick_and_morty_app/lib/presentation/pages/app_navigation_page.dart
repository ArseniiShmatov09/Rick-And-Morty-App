import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/pages/character_list_page/characters_list_widget.dart';
import 'package:rick_and_morty_app/presentation/pages/settings_page.dart';

class AppNavigationPage extends StatefulWidget {
  const AppNavigationPage({super.key});

  @override
  State<AppNavigationPage> createState() => _AppNavigationPageState();
}

class _AppNavigationPageState extends State<AppNavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) =>
        {
          setState(() {
            currentPageIndex = value;
          }),
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'All characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const CharactersListPage(),
        const SettingsPage(),
      ][currentPageIndex],
    );
  }
}
