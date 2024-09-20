import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import '../dto/api_info.dart';
import '../dto/character.dart';
import '../dto/characters_response.dart';
import 'interfaces/abstract_characters_list_data_source.dart';

class CharactersListDataSource implements AbstractCharactersListDataSource {

  CharactersListDataSource(
    this.dio,
    this.charactersBox,
  );

  final Dio dio;
  final Box<CharacterDTO> charactersBox;

  @override
  Future<CharactersResponseDTO> loadAllCharacters(int page) async {
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
        await charactersBox.putAll(charactersMap);
      }
    } catch (e) {
      charactersList = charactersBox.values.toList();
      charactersResponse.characters = charactersList;
    }

    return charactersResponse;
  }

  @override
  Future<CharactersResponseDTO> loadFilteredCharacters(
      String? status,
      String? species,
      int page,
      ) async {

    final Response<Map<String, dynamic>> response = await dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: <String, dynamic>{
        'status': status,
        'species': species,
        'page': page.toString(),
      },
    );
    final data = response.data as Map<String, dynamic>;
    final charactersList = CharactersResponseDTO.fromJson(data);
    return charactersList;
  }

  Future<CharactersResponseDTO> _fetchAllCharacters(int page) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: <String, dynamic>{
        'page': page.toString(),
      },
    );
    final data = response.data as Map<String, dynamic>;
    final charactersList = CharactersResponseDTO.fromJson(data);
    return charactersList;
  }
}