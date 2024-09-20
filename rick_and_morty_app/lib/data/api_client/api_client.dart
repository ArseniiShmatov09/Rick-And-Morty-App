import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/dto/character.dart';
import 'package:rick_and_morty_app/data/dto/episode.dart';

class ApiClient {

  ApiClient(
    this.charactersBox,
    this.episodesBox,
  );

  final _client = HttpClient();
  static const _host = 'https://rickandmortyapi.com/api';
  final Box<CharacterDTO> charactersBox;
  final Box<EpisodeDTO> episodesBox;

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser,
    [Map<String, dynamic>? parameters]
    ) async {

    final url = _makeUri(path, parameters);
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsonDecode());
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
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value){
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
