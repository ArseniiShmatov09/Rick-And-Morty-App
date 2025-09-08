import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';

void main() {
  test('EpisodeModel should store data correctly', () {
    final episode = EpisodeModel(
      id: 1,
      name: 'Pilot',
      airDate: '2013-12-02',
      episode: 'S01E01',
      characters: ['Rick', 'Morty'],
      url: 'url',
      created: DateTime(2013, 12, 2),
    );

    expect(episode.name, 'Pilot');
    expect(episode.characters, contains('Morty'));
    expect(episode.props.contains('S01E01'), true);
  });
}
