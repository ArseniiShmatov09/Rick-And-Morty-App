import '../../data/dto/episode.dart';

abstract class AbstractEpisodeRepository {
  Future<EpisodeDTO> getEpisode(int episodeId);
}