// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
// import 'package:rick_and_morty_app/domain/entities/character.dart';
// import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
// import 'package:rick_and_morty_app/domain/entities/episode.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class CharacterModel extends ChangeNotifier {
//
//   CharacterModel(this.charactersBox, this.episodesBox, this.characterId) {
//     _apiClient = ApiClient(charactersBox, episodesBox);
//   }
//
//   Episode? firstEpisode;
//   String? formattedDateOfCreation;
//
//   late final ApiClient _apiClient;
//   final Box<Character> charactersBox;
//   final Box<Episode> episodesBox;
//
//   final int characterId;
//   Character? _character;
//   Character? get character => _character;
//
//   bool _isLoadInprogress = false;
//   bool get isLoadInprogress => _isLoadInprogress;
//
//   String formatDate(String dateStr) {
//     DateTime dateTime = DateTime.parse(dateStr);
//     return DateFormat('yyyy-MM-dd').format(dateTime);
//   }
//
//   Future<void> loadDetails() async {
//     if (_isLoadInprogress) return;
//
//     _isLoadInprogress = true;
//
//     try {
//       _character = await _apiClient.getCharacter(characterId);
//
//       if (_character != null) {
//         final firstEpisodeUrl = _character!.episode.first;
//         final episodeId = firstEpisodeUrl.split('/').last;
//         firstEpisode = await _apiClient.getEpisode(int.parse(episodeId));
//         formattedDateOfCreation = formatDate(_character!.created);
//       }
//     } catch (e) {
//       print('Error loading character details: $e');
//     } finally {
//       _isLoadInprogress = false;
//       notifyListeners();
//     }
//   }
// }