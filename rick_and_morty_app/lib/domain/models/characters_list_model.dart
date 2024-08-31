import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

class CharactersListModel extends ChangeNotifier {
  final _appClient = ApiClient();
  final _characters = <Character> [];
  List<Character> get characters => List.unmodifiable(_characters);

  Future<void> loadCharacters() async {
    final charactersResponse = await _appClient.getCharacters();
    _characters.addAll(charactersResponse.characters);
    notifyListeners();
  }
}