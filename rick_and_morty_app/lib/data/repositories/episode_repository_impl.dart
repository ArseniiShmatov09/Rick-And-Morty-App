import 'package:rick_and_morty_app/domain/entities/episode_entity.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';
import '../data_sources/interfaces/abstract_episode_data_source.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {

  final AbstractEpisodeDataSource _abstractEpisodeDataSource;

  EpisodeRepositoryImpl({
    required AbstractEpisodeDataSource abstractEpisodeDataSource,
  })  : _abstractEpisodeDataSource = abstractEpisodeDataSource;

  @override
  Future<EpisodeEntity> getEpisode(int episodeId) {
    return _abstractEpisodeDataSource.loadEpisode(episodeId);
  }
}