import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import '../entities/api_info.dart';
import '../entities/character.dart';
import '../entities/characters_response.dart';
import 'interfaces/abstract_characters_list_data_source.dart';

class CharactersListDataSource implements AbstractCharactersListDataSource {

  CharactersListDataSource(
    this.dio,
    this.charactersBox,
  );

  final Dio dio;
  final Box<CharacterEntity> charactersBox;

  @override
  Future<CharactersResponseEntity> loadAllCharacters(int page) async {
    final ApiInfoEntity apiInfo = ApiInfoEntity(count: 20, pages: 1);
    List<CharacterEntity> charactersList = [];
    var charactersResponse = CharactersResponseEntity(
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
  Future<CharactersResponseEntity> loadFilteredCharacters(
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
    final charactersList = CharactersResponseEntity.fromJson(data);
    return charactersList;
  }

  Future<CharactersResponseEntity> _fetchAllCharacters(int page) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: <String, dynamic>{
        'page': page.toString(),
      },
    );
    final data = response.data as Map<String, dynamic>;
    final charactersList = CharactersResponseEntity.fromJson(data);
    return charactersList;
  }
}