// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeAdapter extends TypeAdapter<EpisodeEntity> {
  @override
  final int typeId = 3;

  @override
  EpisodeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      airDate: fields[2] as String,
      episode: fields[3] as String,
      characters: (fields[4] as List).cast<String>(),
      url: fields[5] as String,
      created: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EpisodeEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.airDate)
      ..writeByte(3)
      ..write(obj.episode)
      ..writeByte(4)
      ..write(obj.characters)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeEntity _$EpisodeFromJson(Map<String, dynamic> json) => EpisodeEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$EpisodeToJson(EpisodeEntity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
    };
