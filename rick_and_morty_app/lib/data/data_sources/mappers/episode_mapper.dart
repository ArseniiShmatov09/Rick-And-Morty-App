import '../../../domain/models/episode_model.dart';
import '../../entities/episode.dart';

class EpisodeMapper  {
  EpisodeModel toEntity (EpisodeEntity entity) => EpisodeModel (
    id: entity.id,
    name: entity.name,
    airDate: entity.airDate,
    episode: entity.episode,
    characters: entity.characters,
    url: entity.url,
    created: entity.created,
  );

  EpisodeEntity fromEntity (EpisodeModel model) => EpisodeEntity (
    id: model.id,
    name: model.name,
    airDate: model.airDate,
    episode: model.episode,
    characters: model.characters,
    url: model.url,
    created: model.created,
  );
}