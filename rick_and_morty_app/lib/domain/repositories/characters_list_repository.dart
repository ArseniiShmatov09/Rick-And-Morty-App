import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/entities/api_info.dart';
import '../../data/entities/character.dart';
import '../../data/entities/characters_response.dart';

class CharactersListRepository {

  CharactersListRepository(
    this.charactersBox,
    this.apiClient,
  );

  final Box<Character> charactersBox;
  final ApiClient apiClient;

  Future<CharactersResponse> getAllCharacters(int page) async {
    final ApiInfo apiInfo = ApiInfo(count: 20, pages: 1);
    List<Character> charactersList = [];
    var charactersResponse = CharactersResponse(
      info: apiInfo,
      characters: charactersList,
    );
    try{
      charactersResponse = await _fetchAllCharacters(page);
      charactersList = charactersResponse.characters;
      final charactersMap = {for (var e in charactersList) e.name: e};
      if(page == 1) {
        await charactersBox.putAll(charactersMap);
      }
    } catch (e) {
      charactersList = charactersBox.values.toList();
      charactersResponse.characters = charactersList;
    }

    return charactersResponse;
  }

  Future<CharactersResponse> getFilteredCharacters(
      String? status,
      String? species,
      int page,
      ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponse.fromJson(jsonMap);
      return response;
    }
    final result = apiClient.get(
      '/character',
      parser,
      <String, dynamic>{
        'status': status,
        'species': species,
        'page': page.toString(),
      },
    );
    return result;
  }

  Future<CharactersResponse> _fetchAllCharacters(int page) async {

    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponse.fromJson(jsonMap);
      return response;
    }

    final result = apiClient.get(
      '/character',
      parser,
      <String, dynamic> {'page': page.toString(),},
    );
    return result;
  }

}