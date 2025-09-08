import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';
import 'package:rick_and_morty_app/domain/usecases/get_episode.dart';

class MockEpisodeRepository extends Mock implements EpisodeRepository {}

void main() {
  late MockEpisodeRepository repository;
  late GetEpisode usecase;

  setUp(() {
    repository = MockEpisodeRepository();
    usecase = GetEpisode(episodeRepository: repository);
  });

  test('should return EpisodeModel when repository succeeds', () async {
    final episode = EpisodeModel(
      id: 1,
      name: 'Pilot',
      airDate: '2013-12-02',
      episode: 'S01E01',
      characters: ['Rick', 'Morty'],
      url: 'url',
      created: DateTime(2013, 12, 2),
    );

    when(() => repository.getEpisode(1)).thenAnswer((_) async => episode);

    final result = await usecase(1);

    expect(result, episode);
    verify(() => repository.getEpisode(1)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should throw Exception when repository fails', () async {
    when(() => repository.getEpisode(404)).thenThrow(Exception('Episode not found'));

    expect(() => usecase(404), throwsA(isA<Exception>()));
    verify(() => repository.getEpisode(404)).called(1);
  });
}
