import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_list/character_list_bloc.dart';
import '../../presentation/bloc/character_details/character_details_bloc.dart';
import '../../presentation/pages/app_navigation_page.dart';
import '../../presentation/pages/character_details_page/character_details_page.dart';

class PageFactory {

  Widget makeCharactersList() {
    return BlocProvider(
      create: (context) => CharacterListBloc(),
      child: const AppNavigationPage(),
    );
  }

  Widget makeCharacterDetailsPage(int characterId) {
    return BlocProvider(
      create: (context) => CharacterDetailsBloc(),
      child: CharacterDetailsPage(characterId: characterId,),
    );
  }
}