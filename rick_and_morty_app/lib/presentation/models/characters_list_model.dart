import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/characters_response.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';
import '../../data/entities/episode.dart';

class CharactersListModel extends ChangeNotifier {

  CharactersListModel(this.charactersBox, this.episodesBox) {
    _apiClient = ApiClient(charactersBox, episodesBox);
    _charactersListRepository = CharactersListRepository(charactersBox, _apiClient);
  }

  late final CharactersListRepository _charactersListRepository;
  late final ApiClient _apiClient;
  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;

  final _characters = <Character>[];

  int _currentPage = 1;
  int _pageCount = 1;

  String? _species;
  String? _status;

  bool _isLoadInProgress = false;
  bool hasMoreData = true;

  List<Character> get characters => List.unmodifiable(_characters);

  Future<void> setup() async {
    _currentPage = 1;
    _pageCount = 1;
    _characters.clear();
    await loadNextPage();
    notifyListeners();
  }

  Future<CharactersResponse> _loadCharacters(int nextPage) async {
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
