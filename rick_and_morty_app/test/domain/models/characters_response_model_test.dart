import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

void main() {
  test('CharactersResponseModel should hold info and characters', () {
    final info = ApiInfoModel(count: 2, pages: 1);
    final character = CharacterModel(
      id: 1,
      name: 'Morty',
      status: 'Alive',
      species: 'Human',
      type: null,
      gender: 'Male',
      origin: LocationInfoModel(name: 'Earth'),
      location: LocationInfoModel(name: 'Earth'),
      url: 'url',
      image: 'img.png',
      episode: [],
      created: '2023-01-01',
    );

    final response = CharactersResponseModel(info: info, characters: [character]);

    expect(response.info.count, 2);
    expect(response.characters.first.name, 'Morty');
    expect(response.props, [info, [character]]);
  });
}
