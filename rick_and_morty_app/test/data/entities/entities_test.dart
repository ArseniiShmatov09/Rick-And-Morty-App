import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/data/entities/api_info.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/characters_response.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';

void main() {
  group('Entity Serialization/Deserialization', () {

    test('CharacterEntity should be correctly created fromJson', () {
      final Map<String, dynamic> json = {
        "id": 1, "name": "Rick Sanchez", "status": "Alive", "species": "Human", "type": "", "gender": "Male",
        "origin": {"name": "Earth (C-137)", "url": "some_url"},
        "location": {"name": "Citadel of Ricks", "url": "some_url"},
        "image": "image_url", "episode": ["ep1"], "created": "2017-11-04T18:48:46.250Z", "url": "char_url"
      };

      final character = CharacterEntity.fromJson(json);

      expect(character.id, 1);
      expect(character.name, "Rick Sanchez");
      expect(character.origin.name, "Earth (C-137)");
    });

    test('CharactersResponseEntity should be correctly created fromJson', () {
      final Map<String, dynamic> json = {
        "info": {"count": 826, "pages": 42, "next": "some_url", "prev": null},
        "results": [
          {
            "id": 1, "name": "Rick Sanchez", "status": "Alive", "species": "Human", "type": "", "gender": "Male",
            "origin": {"name": "Earth (C-137)", "url": "some_url"},
            "location": {"name": "Citadel of Ricks", "url": "some_url"},
            "image": "image_url", "episode": ["ep1"], "created": "2017-11-04T18:48:46.250Z", "url": "char_url"
          }
        ]
      };

      final response = CharactersResponseEntity.fromJson(json);

      expect(response.info.count, 826);
      expect(response.characters.length, 1);
      expect(response.characters.first.name, "Rick Sanchez");
    });

    test('EpisodeEntity should be correctly created fromJson with snake_case', () {
      final Map<String, dynamic> json = {
        "id": 28, "name": "The Ricklantis Mixup", "air_date": "September 10, 2017",
        "episode": "S03E07", "characters": [], "url": "ep_url",
        "created": "2017-11-10T12:56:36.618Z"
      };

      final episode = EpisodeEntity.fromJson(json);

      expect(episode.id, 28);
      expect(episode.name, "The Ricklantis Mixup");
      expect(episode.airDate, "September 10, 2017");
      expect(episode.created, isA<DateTime>());
    });

    test('ApiInfoEntity should be correctly converted toJson', () {
      final apiInfo = ApiInfoEntity(count: 10, pages: 1, next: 'next_url', prev: null);

      final json = apiInfo.toJson();

      expect(json['count'], 10);
      expect(json['next'], 'next_url');
      expect(json['prev'], null);
    });
  });
}