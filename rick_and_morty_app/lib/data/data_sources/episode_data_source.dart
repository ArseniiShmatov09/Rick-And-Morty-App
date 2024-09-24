import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import '../entities/episode.dart';
import 'interfaces/abstract_episode_data_source.dart';

class EpisodeDataSource implements AbstractEpisodeDataSource{

  EpisodeDataSource(
    this.dio,
    this.episodesBox
  );

  final Dio dio;
  final Box<EpisodeEntity> episodesBox;

  @override
  Future<EpisodeEntity> loadEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return episodesBox.get(episodeId)!;
    }
  }

  Future<EpisodeEntity> _fetchEpisode(int episodeId) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      'https://rickandmortyapi.com/api/episode/$episodeId',
    );
    final data = response.data as Map<String, dynamic>;
    final episode = EpisodeEntity.fromJson(data);
    return episode;
  }
}