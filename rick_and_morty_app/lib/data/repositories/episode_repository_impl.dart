import 'package:rick_and_morty_app/data/data_sources/mappers/episode_mapper.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';
import '../data_sources/interfaces/abstract_episode_data_source.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {

  final AbstractEpisodeDataSource _abstractEpisodeDataSource;
  final EpisodeMapper _episodeMapper = EpisodeMapper();

  EpisodeRepositoryImpl({
    required AbstractEpisodeDataSource abstractEpisodeDataSource,
  }) : _abstractEpisodeDataSource = abstractEpisodeDataSource;

  @override
  Future<EpisodeModel> getEpisode(int episodeId) async {
    final episodeDTO = await _abstractEpisodeDataSource.loadEpisode(episodeId);
    return _episodeMapper.toEntity(episodeDTO);
  }
}