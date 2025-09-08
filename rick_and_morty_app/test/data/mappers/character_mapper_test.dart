import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/character_mapper.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

void main() {
  final mapper = CharacterMapper();

  final entity = CharacterEntity(
    id: 1,
    name: 'Rick',
    status: 'Alive',
    species: 'Human',
    type: null,
    gender: 'Male',
    origin: LocationInfoEntity(name: 'Earth', url: 'url'),
    location: LocationInfoEntity(name: 'Citadel', url: 'url2'),
    episode: ['ep1'],
    url: 'url',
    image: 'img.png',
    created: '2023-01-01',
  );

  test('should map CharacterEntity -> CharacterModel', () {
    final model = mapper.toModel(entity);

    expect(model.id, entity.id);
    expect(model.name, 'Rick');
    expect(model.origin.name, 'Earth');
    expect(model.location.name, 'Citadel');
  });

  test('should map CharacterModel -> CharacterEntity', () {
    final model = mapper.toModel(entity);
    final newEntity = mapper.fromModel(model);

    expect(newEntity.id, entity.id);
    expect(newEntity.name, entity.name);
    expect(newEntity.origin.name, entity.origin.name);
  });
}
