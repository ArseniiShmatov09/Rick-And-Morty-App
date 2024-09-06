import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';
import 'package:rick_and_morty_app/ui/pages/character_details.dart/character_details.dart';
import 'package:rick_and_morty_app/ui/pages/characters_list/characters_list.dart';
import 'package:rick_and_morty_app/ui/pages/main_page/main_page.dart';
import 'package:rick_and_morty_app/ui/pages/internet_check_screen/Internet_check_screen.dart';
import 'package:rick_and_morty_app/ui/pages/settings/settings.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/characters_response.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = 'main/';
  static const characterDetails = 'character_details/';
  static const settings = 'settings/';
  static const offlineMode = 'offlineMode/';
}

class MainNavigation {

  final Box<Character> charactersBox;

  MainNavigation(
      this.charactersBox,
      );

  String initialRoute =  MainNavigationRouteNames.mainScreen;

  Map<String, Widget Function(BuildContext)> get routes => {
    MainNavigationRouteNames.settings: (context) => SettingsPage(),
    MainNavigationRouteNames.offlineMode: (context) => InternetCheckScreen(),
    MainNavigationRouteNames.mainScreen: (context) => ChangeNotifierProvider(
      create: (context) => CharactersListModel(charactersBox),
      child: MainScreen(),
    ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.characterDetails:
        final arguments = settings.arguments;
        final characterId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CharacterModel(charactersBox, characterId),
            child: CharacterDetails(),
          ),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}