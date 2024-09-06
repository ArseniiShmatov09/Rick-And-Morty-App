// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 2;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      id: fields[1] as int,
      name: fields[2] as String,
      status: fields[3] as String,
      species: fields[4] as String,
      type: fields[0] as String?,
      gender: fields[5] as String,
      origin: fields[6] as LocationInfo,
      location: fields[7] as LocationInfo,
      episode: (fields[8] as List).cast<String>(),
      url: fields[9] as String,
      image: fields[10] as String,
      created: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.species)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.origin)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.episode)
      ..writeByte(9)
      ..write(obj.url)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationInfoAdapter extends TypeAdapter<LocationInfo> {
  @override
  final int typeId = 5;

  @override
  LocationInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationInfo(
      name: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String?,
      gender: json['gender'] as String,
      origin: LocationInfo.fromJson(json['origin'] as Map<String, dynamic>),
      location: LocationInfo.fromJson(json['location'] as Map<String, dynamic>),
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      image: json['image'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin.toJson(),
      'location': instance.location.toJson(),
      'episode': instance.episode,
      'url': instance.url,
      'image': instance.image,
      'created': instance.created,
    };

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) => LocationInfo(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$LocationInfoToJson(LocationInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
