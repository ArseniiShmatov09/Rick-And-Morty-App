// import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
// import 'package:rick_and_morty_app/domain/entities/character.dart';
// import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
//
// class CharactersListRepository {
//   final _apiClient = ApiClient();
//   int _currentPage = 0;
//   bool _hasMoreData = true;
//   String? _status;
//   String? _species;
//   final int _limit = 20;
//
//   Future<List<Character>> loadNextPage({required bool reset, int? page}) async {
//     if (reset) {
//       _currentPage = 0;
//       _hasMoreData = true;
//     } else if (!_hasMoreData) {
//       return [];
//     }
//
//     final currentPage = page ?? ++_currentPage;
//     CharactersResponse response;
//     if (_status == null && _species == null) {
//       response = await _apiClient.getAllCharacters(currentPage);
//     } else {
//       response = await _apiClient.getFilteredCharacters(_status, _species, currentPage);
//     }
//
//     if (response.characters.length < _limit) {
//       _hasMoreData = false;
//     }
//
//     return response.characters;
//   }
//
//   void setFilters(String? status, String? species) {
//     _status = status;
//     _species = species;
//   }
// }
