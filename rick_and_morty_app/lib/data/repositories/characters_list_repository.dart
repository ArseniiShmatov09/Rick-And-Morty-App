import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_characters_list_repository.dart';
import '../dto/api_info.dart';
import '../dto/character.dart';
import '../dto/characters_response.dart';

class CharactersListRepository implements AbstractCharactersListRepository {

  CharactersListRepository(
    this.apiClient,
  );

  final ApiClient apiClient;

  @override
  Future<CharactersResponseDTO> getAllCharacters(int page) async {
    final ApiInfoDTO apiInfo = ApiInfoDTO(count: 20, pages: 1);
    List<CharacterDTO> charactersList = [];
    var charactersResponse = CharactersResponseDTO(
      info: apiInfo,
      characters: charactersList,
    );
    try{
      charactersResponse = await _fetchAllCharacters(page);
      charactersList = charactersResponse.characters;
      final charactersMap = {for (var e in charactersList) e.name: e};
      if(page == 1) {
        await apiClient.charactersBox.putAll(charactersMap);
      }
    } catch (e) {
      charactersList = apiClient.charactersBox.values.toList();
      charactersResponse.characters = charactersList;
    }

    return charactersResponse;
  }

  @override
  Future<CharactersResponseDTO> getFilteredCharacters(
      String? status,
      String? species,
      int page,
      ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponseDTO.fromJson(jsonMap);
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

  Future<CharactersResponseDTO> _fetchAllCharacters(int page) async {

    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponseDTO.fromJson(jsonMap);
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