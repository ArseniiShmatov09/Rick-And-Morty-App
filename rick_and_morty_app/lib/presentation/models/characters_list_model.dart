import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';
import '../../data/data_sources/interfaces/abstract_characters_list_data_source.dart';
import '../../data/dto/character.dart';
import '../../data/dto/characters_response.dart';

class CharactersListModel extends ChangeNotifier {

  final CharactersListRepository
    _charactersListRepository = GetIt.I<CharactersListRepository>();

  final _characters = <CharacterEntity>[];

  int _currentPage = 1;
  int _pageCount = 1;

  String? _species;
  String? _status;

  bool _isLoadInProgress = false;
  bool hasMoreData = true;

  List<CharacterEntity> get characters => List.unmodifiable(_characters);

  Future<void> setup() async {
    _currentPage = 1;
    _pageCount = 1;
    _characters.clear();
    await loadNextPage();
    notifyListeners();
  }

  Future<CharactersResponseEntity> _loadCharacters(int nextPage) async {
    if (_status == 'All') {
      _status = null;
    }
    if (_species == 'All') {
      _species = null;
    }
    if (_status == null && _species == null) {
      return await _charactersListRepository.getAllCharacters(nextPage);
    } else {
      return await _charactersListRepository.getFilteredCharacters(_status, _species, nextPage);
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoadInProgress || _currentPage > _pageCount) return;
    _isLoadInProgress = true;

    try {
      final charactersResponse = await _loadCharacters(_currentPage);
      _characters.addAll(charactersResponse.characters);
      _pageCount = charactersResponse.info.pages;
      hasMoreData = _currentPage < _pageCount;
      _currentPage++;
    } catch (e) {
      hasMoreData = false;
    } finally {
      _isLoadInProgress = false;
      notifyListeners();
    }
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
