import '../../data/entities/episode.dart';

abstract class AbstractEpisodeRepository {
  Future<Episode> getEpisode(int episodeId);
}