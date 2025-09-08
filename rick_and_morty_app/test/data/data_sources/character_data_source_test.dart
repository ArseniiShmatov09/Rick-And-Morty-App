import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/data/data_sources/character_data_source.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class MockDio extends Mock implements Dio {}
class MockBox extends Mock implements Box<CharacterEntity> {}
class CharacterEntityFake extends Fake implements CharacterEntity {}

void main() {
  late MockDio dio;
  late MockBox box;
  late CharacterDataSource dataSource;

  final mockEntity = CharacterEntity(
    id: 1,
    name: 'Rick',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: LocationInfoEntity(name: 'Earth', url: 'url'),
    location: LocationInfoEntity(name: 'Citadel', url: 'url2'),
    episode: ['ep1'],
    url: 'url',
    image: 'rick.png',
    created: '2023-01-01',
  );
  final mockJsonResponse = <String, dynamic>{
    "id": 1, "name": "Rick", "status": "Alive", "species": "Human", "type": "",
    "gender": "Male",
    "origin": <String, dynamic>{"name": "Earth", "url": "url"},
    "location": <String, dynamic>{"name": "Citadel", "url": "url2"},
    "episode": ["ep1"], "url": "url", "image": "rick.png", "created": "2023-01-01",
  };

  setUpAll(() {
    registerFallbackValue(CharacterEntityFake());
  });

  setUp(() {
    dio = MockDio();
    box = MockBox();
    dataSource = CharacterDataSource(dio, box);
  });

  test('should fetch character from API and save to cache', () async {
    when(() => dio.get<Map<String, dynamic>>(any())).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
        data: mockJsonResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    when(() => box.put(any(), any())).thenAnswer((_) async {});

    final result = await dataSource.loadCharacter(1);

    expect(result, isA<CharacterEntity>());
    expect(result.name, 'Rick');
    verify(() => dio.get<Map<String, dynamic>>(any())).called(1);
    verify(() => box.put(1, any())).called(1);
    verifyNever(() => box.get(any()));
  });

  test('should return cached character when API fails', () async {
    when(() => dio.get(any())).thenThrow(Exception('network error'));
    when(() => box.get(1)).thenReturn(mockEntity);

    final result = await dataSource.loadCharacter(1);

    expect(result.name, 'Rick');
    verify(() => box.get(1)).called(1);
    verifyNever(() => box.put(any(), any()));
  });
}