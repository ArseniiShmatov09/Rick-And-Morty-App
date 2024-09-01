import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String? type;
  final String gender;
  final LocationInfo origin;
  final LocationInfo location;
  final List<String> episode;
  final String url;
  final String image;
  final String created;

  Character({
    required this.id, 
    required this.name, 
    required this.status, 
    required this.species, 
    required this.type, 
    required this.gender, 
    required this.origin, 
    required this.location, 
    required this.episode, 
    required this.url, 
    required this.image, 
    required this.created
  });

   factory Character.fromJson(Map<String, dynamic> json) =>
    _$CharacterFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}


@JsonSerializable()
class LocationInfo{
   final String name;
   final String url;

  LocationInfo({
    required this.name, 
    required this.url
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
    _$LocationInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}

