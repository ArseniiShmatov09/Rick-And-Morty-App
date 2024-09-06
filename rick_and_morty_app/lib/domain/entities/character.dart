import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';
part 'character.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Character {

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
  final LocationInfo origin;
  @HiveField(7)
  final LocationInfo location;
  @HiveField(8)
  final List<String> episode;
  @HiveField(9)
  final String url;
  @HiveField(10)
  final String image;
  @HiveField(11)
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

@HiveType(typeId: 5)
@JsonSerializable()
class LocationInfo{
  @HiveField(1)
   final String name;
  @HiveField(2)
   final String url;

  LocationInfo({
    required this.name, 
    required this.url
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
    _$LocationInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}

