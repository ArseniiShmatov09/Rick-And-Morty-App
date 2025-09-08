import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/data/data_sources/episode_data_source.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';

class MockDio extends Mock implements Dio {}
class MockEpisodeBox extends Mock implements Box<EpisodeEntity> {}

class EpisodeEntityFake extends Fake implements EpisodeEntity {}

void main() {
  late MockDio dio;
  late MockEpisodeBox box;
  late EpisodeDataSource dataSource;

  final mockEpisodeEntity = EpisodeEntity(
    id: 1, name: 'Pilot', airDate: 'December 2, 2013', episode: 'S01E01',
    characters: [], url: '', created: DateTime.now(),
  );

  final mockEpisodeJson = <String, dynamic>{
    "id": 1, "name": "Pilot", "air_date": "December 2, 2013", "episode": "S01E01",
    "characters": [], "url": "", "created": ""
  };

  setUpAll(() {
    registerFallbackValue(EpisodeEntityFake());
  });

  setUp(() {
    dio = MockDio();
    box = MockEpisodeBox();
    dataSource = EpisodeDataSource(dio, box);
  });

  group('loadEpisode', () {
    test('should return cached episode when API fails', () async {
      when(() => box.get(1)).thenReturn(mockEpisodeEntity);

      final result = await dataSource.loadEpisode(1);

      expect(result.name, 'Pilot');

      verify(() => dio.get<Map<String, dynamic>>(any())).called(1);

      verify(() => box.get(1)).called(1);
      verifyNever(() => box.put(any(), any()));
    });

    test('should return cached episode when API fails', () async {
      when(() => dio.get<Map<String, dynamic>>(any())).thenThrow(Exception('network error'));
      when(() => box.get(1)).thenReturn(mockEpisodeEntity);

      final result = await dataSource.loadEpisode(1);

      expect(result.name, 'Pilot');
      verify(() => dio.get<Map<String, dynamic>>(any())).called(1);
      verify(() => box.get(1)).called(1);
      verifyNever(() => box.put(any(), any()));
    });
  });
}