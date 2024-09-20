import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/dto/character.dart';
import '../../domain/interfaces/abstract_character_repository.dart';

class CharacterRepository implements AbstractCharacterRepository {

  CharacterRepository(
    this.apiClient,
  );

  final ApiClient apiClient;

  @override
  Future<CharacterDTO> getCharacter(int characterId) async {
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