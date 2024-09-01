import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

class CharactersListModel extends ChangeNotifier {

  final _appClient = ApiClient();
  final _characters = <Character> [];
  late String selectedStatus = '';
  late String selectedSpecies = '';
  
  List<Character> get characters => List.unmodifiable(_characters);

  Future<void> loadCharacters(int page) async {
    _resetList();
    final charactersResponse = await _appClient.getCharacters(page);
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

  Future<void> selectStatus(String? value) async {
    value == null? selectedStatus = '' : selectedStatus = value;  
  }

  Future<void> selectSpecies(String? value) async {
    value == null? selectedSpecies = '' : selectedSpecies = value;  
  }
}