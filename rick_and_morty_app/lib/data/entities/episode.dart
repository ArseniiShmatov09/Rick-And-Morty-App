// ignore_for_file: overridden_fields

import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(fieldRename: FieldRename.snake)
class EpisodeEntity {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String airDate;

  @HiveField(3)
  final String episode;

  @HiveField(4)
  final List<String> characters;

  @HiveField(5)
  final String url;
  
  @HiveField(6)
  final DateTime created;

  EpisodeEntity({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory EpisodeEntity.fromJson(Map<String, dynamic> json) =>
    _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}