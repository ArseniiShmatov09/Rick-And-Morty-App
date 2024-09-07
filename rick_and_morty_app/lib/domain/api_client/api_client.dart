import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
import 'package:rick_and_morty_app/domain/entities/episode.dart';

import '../entities/api_info.dart';

class ApiClient {

  ApiClient(
    this.charactersBox,
    this.episodesBox,
  );

  final _client = HttpClient();
  static const _host = 'https://rickandmortyapi.com/api';
  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;

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

  Future<CharactersResponse> _fetchAllCharacters(int page) async {

    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/character',
      parser,
      <String, dynamic> {'page': page.toString(),},
    );
    return result;
  }

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

    final result = _get(
      '/character/$chracterId',
      parser,
    );
    return result;
  }

  Future<Episode> getEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return episodesBox.get(episodeId)!;
    }
  }

  Future<Episode> _fetchEpisode(int episodeId) {
      parser(json) {
      final jsonMap = json as Map<String, dynamic>;
      return Episode.fromJson(jsonMap);
    }

    final result =  _get(
      '/episode/$episodeId',
      parser,
    );
    return result;
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
    final result = _get(
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

  Future<T> _get<T>(
      String path,
      T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]
      ) async
  {
    final url = _makeUri(path, parameters);
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsoneDecode());
    final result = parser(json);
    return result;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsoneDecode() async {
    return transform(utf8.decoder).toList().then((value){
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
