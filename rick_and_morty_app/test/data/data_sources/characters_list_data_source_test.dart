import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/data/data_sources/characters_list_data_source.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';

class MockDio extends Mock implements Dio {}
class MockCharacterBox extends Mock implements Box<CharacterEntity> {}

class CharacterEntityFake extends Fake implements CharacterEntity {}
class LocationInfoEntityFake extends Fake implements LocationInfoEntity {}

void main() {
  late MockDio dio;
  late MockCharacterBox box;
  late CharactersListDataSource dataSource;

  final mockCharacterEntity = CharacterEntity(
    id: 1, name: 'Rick Sanchez', status: 'Alive', species: 'Human', type: '', gender: 'Male',
    origin: LocationInfoEntity(name: 'Earth (C-137)', url: ''),
    location: LocationInfoEntity(name: 'Citadel of Ricks', url: ''),
    image: 'url_to_image', episode: [], created: '', url: '',
  );

  final mockCharactersList = [mockCharacterEntity];

  final mockApiResponseJson = <String, dynamic>{
    "info": {"count": 1, "pages": 1, "next": null, "prev": null},
    "results": [
      {
        "id": 1, "name": "Rick Sanchez", "status": "Alive", "species": "Human", "type": "", "gender": "Male",
        "origin": {"name": "Earth (C-137)", "url": ""},
        "location": {"name": "Citadel of Ricks", "url": ""},
        "image": "url_to_image", "episode": [], "created": "", "url": ""
      }
    ]
  };

  setUpAll(() {
    registerFallbackValue(CharacterEntityFake());
    registerFallbackValue(LocationInfoEntityFake());
  });

  setUp(() {
    dio = MockDio();
    box = MockCharacterBox();
    dataSource = CharactersListDataSource(dio, box);
  });

  group('loadAllCharacters', () {
    test('should fetch characters from API and save to cache on page 1', () async {
      when(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: mockApiResponseJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      when(() => box.putAll(any())).thenAnswer((_) async {});

      final result = await dataSource.loadAllCharacters(1);

      expect(result.characters, isA<List<CharacterEntity>>());
      expect(result.characters.first.name, 'Rick Sanchez');
      verify(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters'))).called(1);
      verify(() => box.putAll(any())).called(1);
      verifyNever(() => box.values);
    });

    test('should fetch characters from API and NOT save to cache on page > 1', () async {
      when(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: mockApiResponseJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      await dataSource.loadAllCharacters(2);

      verify(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters'))).called(1);
      verifyNever(() => box.putAll(any()));
    });

    test('should return cached characters when API fails', () async {
      when(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(Exception('network error'));
      when(() => box.values).thenReturn(mockCharactersList);

      final result = await dataSource.loadAllCharacters(1);

      expect(result.characters.length, 1);
      expect(result.characters.first.name, 'Rick Sanchez');
      verify(() => box.values).called(1);
      verifyNever(() => box.putAll(any()));
    });
  });

  group('loadFilteredCharacters', () {
    test('should fetch filtered characters from API', () async {
      when(() => dio.get<Map<String, dynamic>>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: mockApiResponseJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.loadFilteredCharacters('Alive', 'Human', 1);

      expect(result.characters.isNotEmpty, isTrue);
      expect(result.characters.first.status, 'Alive');
      verify(() => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: {
          'status': 'Alive',
          'species': 'Human',
          'page': '1',
        },
      )).called(1);
    });
  });
}