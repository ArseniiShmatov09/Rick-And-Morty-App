import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import '../dto/episode.dart';
import 'interfaces/abstract_episode_data_source.dart';

class EpisodeDataSource implements AbstractEpisodeDataSource{

  EpisodeDataSource(
    this.apiClient,
  );

  final ApiClient apiClient;
  
  @override
  Future<EpisodeDTO> loadEpisode(int episodeId) async {

    try {
      final episode = await _fetchEpisode(episodeId);
      apiClient.episodesBox.put(episodeId, episode);
      return episode;
    } catch(e){
      return apiClient.episodesBox.get(episodeId)!;
    }
  }

  Future<EpisodeDTO> _fetchEpisode(int episodeId) {
    parser(json) {
      final jsonMap = json as Map<String, dynamic>;
      return EpisodeDTO.fromJson(jsonMap);
    }

    final result =  apiClient.get(
      '/episode/$episodeId',
      parser,
    );
    return result;
  }

}