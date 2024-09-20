import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../presentation/bloc/character_details/character_details_bloc.dart';
import '../../presentation/models/characters_list_model.dart';
import '../../presentation/pages/app_navigation_page.dart';
import '../../presentation/pages/character_details_page/character_details_page.dart';

class PageFactory {

  Widget makeCharactersList() {
    return ChangeNotifierProvider(
      create: (context) => CharactersListModel(),
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