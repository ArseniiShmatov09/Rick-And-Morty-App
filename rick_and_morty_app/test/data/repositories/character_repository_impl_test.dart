import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_character_data_source.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

class MockCharacterDataSource extends Mock implements AbstractCharacterDataSource {}

class CharacterEntityFake extends Fake implements CharacterEntity {}
class LocationInfoEntityFake extends Fake implements LocationInfoEntity {}

void main() {
  late MockCharacterDataSource mockDataSource;
  late CharacterRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(CharacterEntityFake());
    registerFallbackValue(LocationInfoEntityFake());
  });

  setUp(() {
    mockDataSource = MockCharacterDataSource();
    repository = CharacterRepositoryImpl(abstractCharacterDataSource: mockDataSource);
  });

  final mockCharacterEntity = CharacterEntity(
    id: 1, name: 'Rick', status: 'Alive', species: 'Human', type: '', gender: 'Male',
    origin: LocationInfoEntity(name: 'Earth', url: ''), location: LocationInfoEntity(name: 'Citadel', url: ''),
    image: '', episode: [], created: '', url: '',
  );

  test('getCharacter should call data source and return a mapped CharacterModel', () async {
    when(() => mockDataSource.loadCharacter(any())).thenAnswer((_) async => mockCharacterEntity);

    final result = await repository.getCharacter(1);

    expect(result, isA<CharacterModel>());
    expect(result.name, 'Rick');
    verify(() => mockDataSource.loadCharacter(1)).called(1);
  });
}