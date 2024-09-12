import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import 'package:rick_and_morty_app/presentation/models/characters_list_model.dart';
import 'package:rick_and_morty_app/presentation/pages/character_details_page/character_details_page.dart';
import 'package:rick_and_morty_app/presentation/pages/main_page.dart';
import 'package:rick_and_morty_app/presentation/pages/Internet_check_page.dart';
import 'package:rick_and_morty_app/presentation/pages/settings_page.dart';
import '../../data/entities/character.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = 'main/';
  static const characterDetails = 'character_details/';
  static const settings = 'settings/';
  static const offlineMode = 'offlineMode/';
}

class MainNavigation {

  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;

  MainNavigation(
    this.charactersBox,
    this.episodesBox,
  );

  String initialRoute =  MainNavigationRouteNames.mainScreen;

  Map<String, Widget Function(BuildContext)> get routes => {
    MainNavigationRouteNames.settings: (context) => const SettingsPage(),
    MainNavigationRouteNames.offlineMode: (context) => const InternetCheckPage(),
    MainNavigationRouteNames.mainScreen: (context) => ChangeNotifierProvider(
      create: (context) => CharactersListModel(charactersBox, episodesBox),
      child: const MainPage(),
    ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.characterDetails:
        final arguments = settings.arguments;
        final characterId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CharacterDetailsBloc(charactersBox, episodesBox),
            child: CharacterDetailsPage(charactersBox: charactersBox, episodesBox : episodesBox, characterId: characterId,),
          ),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}