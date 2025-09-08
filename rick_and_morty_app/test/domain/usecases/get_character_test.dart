import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/domain/usecases/get_character.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository repository;
  late GetCharacter usecase;

  setUp(() {
    repository = MockCharacterRepository();
    usecase = GetCharacter(characterRepository: repository);
  });

  test('should return CharacterModel when repository succeeds', () async {
    final character = CharacterModel(
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
    );

    when(() => repository.getCharacter(1)).thenAnswer((_) async => character);

    final result = await usecase(1);

    expect(result, character);
    verify(() => repository.getCharacter(1)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should throw Exception when repository fails', () async {
    when(() => repository.getCharacter(99)).thenThrow(Exception('Not found'));

    expect(() => usecase(99), throwsA(isA<Exception>()));
    verify(() => repository.getCharacter(99)).called(1);
  });
}
