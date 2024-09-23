class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String? type;
  final String gender;
  final LocationInfoEntity origin;
  final LocationInfoEntity location;
  final List<String> episode;
  final String url;
  final String image;
  final String created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.url,
    required this.image,
    required this.episode,
    required this.created,
  });

  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    episode,
    url,
    image,
    created,
  ];
}

class LocationInfoEntity{
  final String? name;
  final String? url;

  LocationInfoEntity({
    this.name,
    this.url
  });

  List<Object?> get props => [
    name,
    url,
  ];
}

