import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/usecases/get_filtered_characters.dart';

class MockCharactersListRepository extends Mock implements CharactersListRepository {}

void main() {
  late MockCharactersListRepository repository;
  late GetFilteredCharacters usecase;

  setUp(() {
    repository = MockCharactersListRepository();
    usecase = GetFilteredCharacters(repository: repository);
  });

  test('should return filtered CharactersResponseModel', () async {
    final response = CharactersResponseModel(
      info: ApiInfoModel(count: 1, pages: 1),
      characters: [
        CharacterModel(
          id: 2,
          name: 'Morty',
          status: 'Alive',
          species: 'Human',
          type: null,
          gender: 'Male',
          origin: LocationInfoModel(name: 'Earth'),
          location: LocationInfoModel(name: 'Earth'),
          url: 'url',
          image: 'morty.png',
          episode: [],
          created: '2023-01-02',
        )
      ],
    );

    when(() => repository.getFilteredCharacters('Alive', 'Human', 1))
        .thenAnswer((_) async => response);

    final result = await usecase('Alive', 'Human', 1);

    expect(result, response);
    verify(() => repository.getFilteredCharacters('Alive', 'Human', 1)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should throw Exception when repository fails', () async {
    when(() => repository.getFilteredCharacters(any(), any(), any()))
        .thenThrow(Exception('Server error'));

    expect(() => usecase('Dead', null, 1), throwsA(isA<Exception>()));
    verify(() => repository.getFilteredCharacters('Dead', null, 1)).called(1);
  });
}
