import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/characters_response_mapper.dart';
import 'package:rick_and_morty_app/data/entities/api_info.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/characters_response.dart';

void main() {
  final mapper = CharactersResponseMapper();

  final entity = CharactersResponseEntity(
    info: ApiInfoEntity(count: 1, pages: 1),
    characters: [
      CharacterEntity(
        id: 1,
        name: 'Morty',
        status: 'Alive',
        species: 'Human',
        type: null,
        gender: 'Male',
        origin: LocationInfoEntity(name: 'Earth', url: 'url'),
        location: LocationInfoEntity(name: 'Earth', url: 'url2'),
        episode: ['ep1'],
        url: 'url',
        image: 'morty.png',
        created: '2023-01-01',
      )
    ],
  );

  test('should map CharactersResponseEntity -> CharactersResponseModel', () {
    final model = mapper.toModel(entity);

    expect(model.characters.first.name, 'Morty');
    expect(model.info.count, 1);
  });

  test('should map CharactersResponseModel -> CharactersResponseEntity', () {
    final model = mapper.toModel(entity);
    final newEntity = mapper.fromModel(model);

    expect(newEntity.characters.first.id, 1);
    expect(newEntity.info.pages, 1);
  });
}
