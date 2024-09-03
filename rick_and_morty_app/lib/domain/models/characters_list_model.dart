import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

class CharactersListModel extends ChangeNotifier {

  final _appClient = ApiClient();
  final _characters = <Character> [];
  
  List<Character> get characters => List.unmodifiable(_characters);

  Future<void> loadCharacters(int page) async {
    _resetList();
    final charactersResponse = await _appClient.getAllCharacters(page);
    _characters.addAll(charactersResponse.characters);
    notifyListeners();
  }

  Future<void> loadFilteredCharacters(String status, String species, int page) async {
    _resetList();
    final charactersResponse = await _appClient.getFilteredCharacters(status, species, 1);
    _characters.addAll(charactersResponse.characters);
    notifyListeners();
  }

  Future<void> _resetList() async {
    _characters.clear();
  }

  void onCharacterTap(BuildContext context, int index) {
    final id = _characters[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.characterDetails,
      arguments: id,
    );
  }

}