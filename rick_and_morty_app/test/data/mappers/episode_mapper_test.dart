import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/episode_mapper.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';

void main() {
  final mapper = EpisodeMapper();

  final entity = EpisodeEntity(
    id: 1,
    name: 'Pilot',
    airDate: '2013-12-02',
    episode: 'S01E01',
    characters: ['Rick', 'Morty'],
    url: 'url',
    created: DateTime(2013, 12, 2),
  );

  test('should map EpisodeEntity -> EpisodeModel', () {
    final model = mapper.toEntity(entity);

    expect(model.name, 'Pilot');
    expect(model.episode, 'S01E01');
  });

  test('should map EpisodeModel -> EpisodeEntity', () {
    final model = mapper.toEntity(entity);
    final newEntity = mapper.fromEntity(model);

    expect(newEntity.id, 1);
    expect(newEntity.characters.length, 2);
  });
}
