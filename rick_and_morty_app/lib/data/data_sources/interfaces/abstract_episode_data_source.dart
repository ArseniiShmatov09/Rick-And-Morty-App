import '../../dto/episode.dart';

abstract class AbstractEpisodeDataSource {
  Future<EpisodeDTO> loadEpisode(int episodeId);
}