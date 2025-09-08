import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/usecases/get_all_characters.dart';

class MockCharactersListRepository extends Mock implements CharactersListRepository {}

void main() {
  late MockCharactersListRepository repository;
  late GetAllCharacters usecase;

  setUp(() {
    repository = MockCharactersListRepository();
    usecase = GetAllCharacters(repository: repository);
  });

  test('should return CharactersResponseModel when repository succeeds', () async {
    final response = CharactersResponseModel(
      info: ApiInfoModel(count: 1, pages: 1),
      characters: [
        CharacterModel(
          id: 1,
          name: 'Rick',
          status: 'Alive',
          species: 'Human',
          type: null,
          gender: 'Male',
          origin: LocationInfoModel(name: 'Earth'),
          location: LocationInfoModel(name: 'Earth'),
          url: 'url',
          image: 'rick.png',
          episode: [],
          created: '2023-01-01',
        )
      ],
    );

    when(() => repository.getAllCharacters(1)).thenAnswer((_) async => response);

    final result = await usecase(1);

    expect(result, response);
    verify(() => repository.getAllCharacters(1)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should throw Exception when repository fails', () async {
    when(() => repository.getAllCharacters(1)).thenThrow(Exception('Network error'));

    expect(() => usecase(1), throwsA(isA<Exception>()));
    verify(() => repository.getAllCharacters(1)).called(1);
  });
}
