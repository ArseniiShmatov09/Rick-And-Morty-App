import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/entities/character.dart';
import '../interfaces/abstract_character_repository.dart';

class CharacterRepository implements AbstractCharacterRepository {

  CharacterRepository(
    this.apiClient,
  );

  final ApiClient apiClient;

  @override
  Future<Character> getCharacter(int characterId) async {
    try {
      final character = await _fetchCharacter(characterId);
      apiClient.charactersBox.put(characterId, character);
      return character;
    } catch(e){
      return apiClient.charactersBox.get(characterId)!;
    }
  }

  Future<Character> _fetchCharacter(int chracterId) {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = Character.fromJson(jsonMap);
      return response;
    }

    final result = apiClient.get(
      '/character/$chracterId',
      parser,
    );
    return result;
  }

}