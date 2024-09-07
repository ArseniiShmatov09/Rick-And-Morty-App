import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

import '../entities/episode.dart';

class CharactersListModel extends ChangeNotifier {

  CharactersListModel(this.charactersBox, this.episodesBox) {
    _apiClient = ApiClient(charactersBox, episodesBox);
  }

  late final ApiClient _apiClient;
  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;

  final _characters = <Character>[];

  int _currentPage = 1;
  int _pageCount = 1;

  String? _species;
  String? _status;

  bool _isLoadInprogress = false;
  bool hasMoreData = true;

  List<Character> get characters => List.unmodifiable(_characters);

  Future<CharactersResponse> _loadCharacters(int nextPage) async {
    if (_status == null && _species == null) {
      return await _apiClient.getAllCharacters(nextPage);
    } else {
      return await _apiClient.getFilteredCharacters(_status, _species, nextPage);
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoadInprogress || _currentPage > _pageCount) return;
    _isLoadInprogress = true;

    try {
      final charactersResponse = await _loadCharacters(_currentPage);
      _characters.addAll(charactersResponse.characters);
      _pageCount = charactersResponse.info.pages;
      hasMoreData = _currentPage < _pageCount;
      _currentPage++;
    } catch (e) {
      hasMoreData = false;
    } finally {
      _isLoadInprogress = false;
      notifyListeners();
    }
  }

  Future<void> setup() async {
    _currentPage = 1;
    _pageCount = 1;
    _characters.clear();
    await loadNextPage();
    notifyListeners();
  }


  Future<void> loadFilteredCharacters(String status, String species, int page) async {
    _status = status;
    _species = species;
    await setup();
  }

  void onCharacterTap(BuildContext context, int index) {
    final id = _characters[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.characterDetails,
      arguments: id,
    );
  }
}
