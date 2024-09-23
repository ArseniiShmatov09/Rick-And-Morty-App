import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'character.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class CharacterDTO  {

  
  @HiveField(1)
  final int id;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final String species;

  @HiveField(0)
  final String? type;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final LocationInfoDTO origin;

  @HiveField(7)
  final LocationInfoDTO location;

  @HiveField(8)
  final List<String> episode;

  @HiveField(9)
  final String url;

  @HiveField(10)
  final String image;
  @HiveField(11)

  final String created;

  CharacterDTO({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
    required this.url,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) =>
    _$CharacterFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class LocationInfoDTO{

  @HiveField(1)
   final String? name;

  @HiveField(2)
   final String? url;

  LocationInfoDTO({
    required this.name,
    required this.url
  });

  factory LocationInfoDTO.fromJson(Map<String, dynamic> json) =>
    _$LocationInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}

