import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';

part 'character.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class CharacterDTO  {

  @override
  @HiveField(1)
  final int id;
  @override
  @HiveField(2)
  final String name;
  @override
  @HiveField(3)
  final String status;
  @override
  @HiveField(4)
  final String species;
  @override
  @HiveField(0)
  final String? type;
  @override
  @HiveField(5)
  final String gender;
  @override
  @HiveField(6)
  final LocationInfoDTO origin;
  @override
  @HiveField(7)
  final LocationInfoDTO location;
  @override
  @HiveField(8)
  final List<String> episode;
  @override
  @HiveField(9)
  final String url;
  @override
  @HiveField(10)
  final String image;
  @HiveField(11)
  @override
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
  @override
  @HiveField(1)
   final String? name;
  @override
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

