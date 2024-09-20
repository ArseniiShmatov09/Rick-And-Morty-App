import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_character_data_source.dart';
import '../../data/dto/character.dart';

class CharacterDataSource implements AbstractCharacterDataSource {

  CharacterDataSource(
    this.dio,
    this.charactersBox,
  );

  final Dio dio;
  final Box<CharacterDTO> charactersBox;

  @override
  Future<CharacterDTO> loadCharacter(int characterId) async {
    try {
      final character = await _fetchCharacter(characterId);
      charactersBox.put(characterId, character);
      return character;
    } catch(e){
      return charactersBox.get(characterId)!;
    }
  }

  Future<CharacterDTO> _fetchCharacter(int characterId) async{

    final Response<Map<String, dynamic>> response  = await dio.get(
      'https://rickandmortyapi.com/api/character/$characterId'
    );
    final data = response.data as Map<String, dynamic>;
    final character = CharacterDTO.fromJson(data);
    return character;
  }

}