import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

void main() {
  group('CharacterModel', () {
    test('should hold values correctly', () {
      final location = LocationInfoModel(name: 'Earth', url: 'earth_url');

      final character = CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        type: 'Scientist',
        gender: 'Male',
        origin: location,
        location: location,
        url: 'url',
        image: 'image.png',
        episode: ['ep1', 'ep2'],
        created: '2023-01-01',
      );

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      expect(character.episode.length, 2);
      expect(character.origin.name, 'Earth');
      expect(character.props.contains('Rick Sanchez'), true);
    });
  });
}
