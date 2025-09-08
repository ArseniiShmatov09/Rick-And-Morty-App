import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_episode_data_source.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import 'package:rick_and_morty_app/data/repositories/episode_repository_impl.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';

class MockEpisodeDataSource extends Mock implements AbstractEpisodeDataSource {}
class EpisodeEntityFake extends Fake implements EpisodeEntity {}

void main() {
  late MockEpisodeDataSource mockDataSource;
  late EpisodeRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(EpisodeEntityFake());
  });

  setUp(() {
    mockDataSource = MockEpisodeDataSource();
    repository = EpisodeRepositoryImpl(abstractEpisodeDataSource: mockDataSource);
  });

  final mockEpisodeEntity = EpisodeEntity(
      id: 1, name: 'Pilot', airDate: 'date', episode: 'S01E01',
      characters: [], url: '', created: DateTime.now()
  );

  test('getEpisode should call data source and return a mapped EpisodeModel', () async {
    when(() => mockDataSource.loadEpisode(any())).thenAnswer((_) async => mockEpisodeEntity);

    final result = await repository.getEpisode(1);

    expect(result, isA<EpisodeModel>());
    expect(result.name, 'Pilot');
    verify(() => mockDataSource.loadEpisode(1)).called(1);
  });
}