import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty_app/domain/usecases/get_filtered_characters.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_list/character_list_bloc.dart';
import '../../presentation/bloc/character_details/character_details_bloc.dart';
import '../../presentation/pages/app_navigation_page.dart';
import '../../presentation/pages/character_details_page/character_details_page.dart';
import '../usecases/get_character.dart';
import '../usecases/get_episode.dart';

class PageFactory {

  Widget makeCharactersList() {
    return BlocProvider<CharacterListBloc>(
      create: (context) => CharacterListBloc(
        getAllCharacters: GetIt.I<GetAllCharacters>(),
        getFilteredCharacters: GetIt.I<GetFilteredCharacters>(),
      ),
      child: AppNavigationPage(),
    );
  }

  Widget makeCharacterDetailsPage(int characterId) {
    return BlocProvider<CharacterDetailsBloc>(
      create: (context) => CharacterDetailsBloc(
        getCharacter: GetIt.I<GetCharacter>(),
        getEpisode: GetIt.I<GetEpisode>(),
      ),
      child: CharacterDetailsPage(characterId: characterId,),
    );
  }
}