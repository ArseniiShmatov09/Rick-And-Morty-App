// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharactersResponseAdapter extends TypeAdapter<CharactersResponseDTO> {
  @override
  final int typeId = 1;

  @override
  CharactersResponseDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharactersResponseDTO(
      info: fields[0] as ApiInfoDTO,
      characters: (fields[1] as List).cast<CharacterDTO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharactersResponseDTO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.info)
      ..writeByte(1)
      ..write(obj.characters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharactersResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersResponseDTO _$CharactersResponseFromJson(Map<String, dynamic> json) =>
    CharactersResponseDTO(
      info: ApiInfoDTO.fromJson(json['info'] as Map<String, dynamic>),
      characters: (json['results'] as List<dynamic>)
          .map((e) => CharacterDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharactersResponseToJson(CharactersResponseDTO instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'results': instance.characters.map((e) => e.toJson()).toList(),
    };