// ignore_for_file: overridden_fields

import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/domain/entities/episode_entity.dart';

part 'episode.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(fieldRename: FieldRename.snake)
class EpisodeDTO extends EpisodeEntity {

  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final String airDate;

  @override
  @HiveField(3)
  final String episode;

  @override
  @HiveField(4)
  final List<String> characters;

  @override
  @HiveField(5)
  final String url;
  
  @override
  @HiveField(6)
  final DateTime created;

  EpisodeDTO({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  }): super(
    id: id,
    name: name,
    airDate: airDate,
    episode: episode,
    characters: characters,
    url: url,
    created: created,
  );

  factory EpisodeDTO.fromJson(Map<String, dynamic> json) =>
    _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}