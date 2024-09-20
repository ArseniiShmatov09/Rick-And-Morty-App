import 'package:rick_and_morty_app/domain/entities/episode_entity.dart';

abstract class EpisodeRepository {
  Future<EpisodeEntity> getEpisode(int episodeId);
}