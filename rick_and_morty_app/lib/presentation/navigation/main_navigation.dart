import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/pages/Internet_check_page.dart';
import '../../domain/factories/page_factory.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = 'main/';
  static const characterDetails = 'character_details/';
  static const offlineMode = 'offlineMode/';
}

class MainNavigation {

  String initialRoute =  MainNavigationRouteNames.mainScreen;
  static final _pageFactory = PageFactory();

  Map<String, Widget Function(BuildContext)> get routes => {
    MainNavigationRouteNames.offlineMode: (context) => const InternetCheckPage(),
    MainNavigationRouteNames.mainScreen: (context) => _pageFactory.makeCharactersList(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.characterDetails:
        final arguments = settings.arguments;
        final characterId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _pageFactory.makeCharacterDetailsPage(characterId),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}