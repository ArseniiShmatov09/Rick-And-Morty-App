import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import '../dto/episode.dart';
import 'interfaces/abstract_episode_data_source.dart';

class EpisodeDataSource implements AbstractEpisodeDataSource{

  EpisodeDataSource(
    this.dio,
    this.episodesBox
  );

  final Dio dio;
  final Box<EpisodeDTO> episodesBox;

  @override
  Future<EpisodeDTO> loadEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return episodesBox.get(episodeId)!;
    }
  }

  Future<EpisodeDTO> _fetchEpisode(int episodeId) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      'https://rickandmortyapi.com/api/episode/$episodeId',
    );
    final data = response.data as Map<String, dynamic>;
    final episode = EpisodeDTO.fromJson(data);
    return episode;
  }
}