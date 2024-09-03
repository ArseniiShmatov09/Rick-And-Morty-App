
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';
import 'package:rick_and_morty_app/ui/pages/character_details.dart/character_details.dart';
import 'package:rick_and_morty_app/ui/pages/characters_list/characters_list.dart';
import 'package:rick_and_morty_app/ui/pages/main_page/main_page.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = 'main/';
  static const characterDetails = 'character_details/';
}

class MainNavigation {
 
  String initialRoute =  MainNavigationRouteNames.mainScreen;

  final routes = <String, Widget Function(BuildContext)>{

    MainNavigationRouteNames.mainScreen: (context) => ChangeNotifierProvider(
      create: (context) => CharactersListModel(),
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
            create: (context) => CharacterModel(characterId),
            child: CharacterDetails(),
          ),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}