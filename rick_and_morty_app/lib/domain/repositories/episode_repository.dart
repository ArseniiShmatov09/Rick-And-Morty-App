import 'package:rick_and_morty_app/domain/models/episode_model.dart';

abstract class EpisodeRepository {
  Future<EpisodeModel> getEpisode(int episodeId);
}