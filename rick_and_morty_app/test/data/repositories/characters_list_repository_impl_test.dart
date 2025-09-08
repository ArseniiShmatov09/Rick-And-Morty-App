import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_characters_list_data_source.dart';
import 'package:rick_and_morty_app/data/entities/api_info.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/characters_response.dart';
import 'package:rick_and_morty_app/data/repositories/characters_list_repository_impl.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';

class MockCharactersListDataSource extends Mock implements AbstractCharactersListDataSource {}

void main() {
  late MockCharactersListDataSource mockDataSource;
  late CharactersListRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCharactersListDataSource();
    repository = CharactersListRepositoryImpl(abstractCharactersListDataSource: mockDataSource);
  });

  final mockResponseEntity = CharactersResponseEntity(
    info: ApiInfoEntity(count: 1, pages: 1),
    characters: [
      CharacterEntity(
        id: 1, name: 'Rick', status: 'Alive', species: 'Human', type: '', gender: 'Male',
        origin: LocationInfoEntity(name: 'Earth', url: ''), location: LocationInfoEntity(name: 'Citadel', url: ''),
        image: '', episode: [], created: '', url: '',
      ),
    ],
  );

  test('getAllCharacters should call loadAllCharacters and return a mapped model', () async {
    when(() => mockDataSource.loadAllCharacters(any())).thenAnswer((_) async => mockResponseEntity);

    final result = await repository.getAllCharacters(1);

    expect(result, isA<CharactersResponseModel>());
    expect(result.characters.first.name, 'Rick');
    verify(() => mockDataSource.loadAllCharacters(1)).called(1);
  });

  test('getFilteredCharacters should call loadFilteredCharacters and return a mapped model', () async {
    when(() => mockDataSource.loadFilteredCharacters(any(), any(), any())).thenAnswer((_) async => mockResponseEntity);

    final result = await repository.getFilteredCharacters('Alive', 'Human', 1);

    expect(result, isA<CharactersResponseModel>());
    expect(result.characters.first.name, 'Rick');
    verify(() => mockDataSource.loadFilteredCharacters('Alive', 'Human', 1)).called(1);
  });
}