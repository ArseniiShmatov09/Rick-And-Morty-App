import '../../../domain/entities/episode_entity.dart';
import '../../dto/episode.dart';

class EpisodeMapper  {
  EpisodeEntity toEntity (EpisodeDTO dto) => EpisodeEntity (
    id: dto.id,
    name: dto.name,
    airDate: dto.airDate,
    episode: dto.episode,
    characters: dto.characters,
    url: dto.url,
    created: dto.created,
  );

  EpisodeDTO fromEntity (EpisodeEntity entity) => EpisodeDTO (
    id: entity.id,
    name: entity.name,
    airDate: entity.airDate,
    episode: entity.episode,
    characters: entity.characters,
    url: entity.url,
    created: entity.created,
  );
}