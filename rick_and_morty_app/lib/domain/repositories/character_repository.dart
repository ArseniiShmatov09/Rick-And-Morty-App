import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/entities/character.dart';

class CharacterRepository {

  CharacterRepository(
    this.charactersBox,
    this.apiClient,
  );

  final Box<Character> charactersBox;
  final ApiClient apiClient;

  Future<Character> getCharacter(int chracterId) async {
    try {
      final character = await _fetchCharacter(chracterId);
      charactersBox.put(chracterId, character);
      return character;
    } catch(e){
      return charactersBox.get(chracterId)!;
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