import 'package:rick_and_morty_app/domain/models/episode_model.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';

class GetEpisode {
  GetEpisode({
    required EpisodeRepository episodeRepository,
  }) : _episodeRepository = episodeRepository;

  final EpisodeRepository _episodeRepository;

  Future<EpisodeModel> call(int episodeId) async {
    return await _episodeRepository.getEpisode(episodeId);
  }
}