import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_character_data_source.dart';
import '../../data/dto/character.dart';

class CharacterDataSource implements AbstractCharacterDataSource {

  CharacterDataSource(
    this.apiClient,
  );

  final ApiClient apiClient;

  @override
  Future<CharacterDTO> loadCharacter(int characterId) async {
    try {
      final character = await _fetchCharacter(characterId);
      apiClient.charactersBox.put(characterId, character);
      return character;
    } catch(e){
      return apiClient.charactersBox.get(characterId)!;
    }
  }

  Future<CharacterDTO> _fetchCharacter(int characterId) {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharacterDTO.fromJson(jsonMap);
      return response;
    }

    final result = apiClient.get(
      '/character/$characterId',
      parser,
    );
    return result;
  }

}