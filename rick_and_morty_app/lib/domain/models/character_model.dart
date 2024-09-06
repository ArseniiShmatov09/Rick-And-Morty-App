import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
import 'package:rick_and_morty_app/domain/entities/episode.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterModel extends ChangeNotifier {

  CharacterModel(this.charactersBox, this.characterId) {
    _apiClient = ApiClient(charactersBox);
  }

  Episode? firstEpisode;
  String? formattedDateOfCreation;

  late final ApiClient _apiClient;
  final Box<Character> charactersBox;

  final int characterId;
  Character? _character;
  Character? get character => _character;

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Future<void> loadDetails() async {
    _character = await _apiClient.getCharacter(characterId);

    if (_character != null) {
      final firstEpisodeUrl = _character!.episode.first;
      final episodeId = firstEpisodeUrl.split('/').last;
      firstEpisode = await _apiClient.getEpisode(int.parse(episodeId));
      formattedDateOfCreation = formatDate(_character!.created);
    }
    
    notifyListeners();
  }
}