import '../../entities/episode.dart';

abstract class AbstractEpisodeDataSource {
  Future<EpisodeEntity> loadEpisode(int episodeId);
}