class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  List<Object?> get props => [
    id,
    name,
    airDate,
    episode,
    characters,
    url,
    created,
  ];
}