import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/presentation/widgets/character_list_widget/characters_list_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
            icon: Icon(Icons.home),
            label: 'All characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: const CharactersListWidget(),
    );
  }

}