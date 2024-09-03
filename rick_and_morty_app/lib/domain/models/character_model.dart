import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

class CharacterModel extends ChangeNotifier {
  
  CharacterModel(this.characterId);
  
  final _apiClient = ApiClient();

  final int characterId;
  Character? _character;
  Character? get character => _character;

  Future<void> loadDetails() async {
    _character = await _apiClient.getCharacter(characterId);
    print(_character!.id);
    notifyListeners();
  }
}