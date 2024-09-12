import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/entities/episode.dart';

class EpisodeRepository {

  EpisodeRepository(
    this.episodesBox,
    this.apiClient,
  );

  final Box<Episode> episodesBox;
  final ApiClient apiClient;

  Future<Episode> getEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return episodesBox.get(episodeId)!;
    }
  }

  Future<Episode> _fetchEpisode(int episodeId) {
    parser(json) {
      final jsonMap = json as Map<String, dynamic>;
      return Episode.fromJson(jsonMap);
    }

    final result =  apiClient.get(
      '/episode/$episodeId',
      parser,
    );
    return result;
  }

}