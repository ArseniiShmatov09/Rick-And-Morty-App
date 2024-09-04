import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/ui/pages/characters_list/characters_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) =>
        {
          bottomNavigationSelected(value, context)
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'All characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: CharactersList(),
    );
  }

  void bottomNavigationSelected(int value, BuildContext context) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, MainNavigationRouteNames.mainScreen);
        break;
      case 1:
        Navigator.pushNamed(context, MainNavigationRouteNames.settings);
        break;
      default:
        Navigator.pushNamed(context, MainNavigationRouteNames.mainScreen);
        break;
    }
  }
}