import 'package:rick_and_morty_app/domain/entities/episode_entity.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';

class GetEpisode {
  GetEpisode({
    required EpisodeRepository episodeRepository,
  }) : _episodeRepository = episodeRepository;

  final EpisodeRepository _episodeRepository;

  Future<EpisodeEntity> call(int episodeId) async {
    return await _episodeRepository.getEpisode(episodeId);
  }
}