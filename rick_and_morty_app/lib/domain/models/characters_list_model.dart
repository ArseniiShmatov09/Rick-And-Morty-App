import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

class CharactersListModel extends ChangeNotifier {

  final _apiClient = ApiClient();
  final _characters = <Character>[];
  late int _currentPage;
  late int _pageCount;
  String? _species;
  String? _status;
  var _isLoadInprogress = false;
  final limit = 20;
  bool hasMoreData = true;

  List<Character> get characters => List.unmodifiable(_characters);


  Future<CharactersResponse> _loadCharacters(int nextPage) async {
    final status = _status;
    final species = _species;
    
    if (status == null && species == null) {
      return await _apiClient.getAllCharacters(nextPage);
    } else {
      return await _apiClient.getFilteredCharacters(status, species, nextPage);
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoadInprogress || _currentPage >= _pageCount) return;
    _isLoadInprogress = true;

    final nextPage = _currentPage + 1;
    final charactersResponse = await _loadCharacters(nextPage);
    _characters.addAll(charactersResponse.characters);
    if(charactersResponse.info.next != ''){
      Uri nextPageUri = Uri.parse(charactersResponse.info.next!);

      String? pageNumber = nextPageUri.queryParameters['page'];
      _currentPage = int.parse(pageNumber!) - 1;
    }
    else{
      _currentPage = charactersResponse.info.pages;
    }
    if(charactersResponse.characters.length < limit){
      hasMoreData = false;
    }
    _pageCount = charactersResponse.info.pages;
    _isLoadInprogress = false;
    notifyListeners();
  }

  Future<void> setup() async {
    _currentPage = 0;
    _pageCount = 1;
    _characters.clear();
    await loadNextPage();
  }

  Future<void> loadFilteredCharacters(
    String status, 
    String species, 
    int page
  ) async {
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
