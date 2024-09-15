import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../../data/entities/episode.dart';
import '../interfaces/abstract_episode_repository.dart';

class EpisodeRepository implements AbstractEpisodeRepository{

  EpisodeRepository(
    this.apiClient,
  );

  final ApiClient apiClient;
  
  @override
  Future<Episode> getEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      apiClient.episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return apiClient.episodesBox.get(episodeId)!;
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