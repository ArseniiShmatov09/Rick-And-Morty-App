import 'dart:convert';
import 'dart:io';

import 'package:rick_and_morty_app/domain/entities/characters_response.dart';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://rickandmortyapi.com/api';

  Future<CharactersResponse> getCharacters() async {
    final parser = (dynamic json) { 
      final jsonMap = json as Map<String, dynamic>;
      final response = CharactersResponse.fromJson(jsonMap);
      return response;
    };

    final result = _get(
      '/character',
      parser,
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
