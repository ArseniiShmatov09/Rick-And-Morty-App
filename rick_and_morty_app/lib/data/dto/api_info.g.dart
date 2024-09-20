// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiInfoAdapter extends TypeAdapter<ApiInfoDTO> {
  @override
  final int typeId = 4;

  @override
  ApiInfoDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiInfoDTO(
      count: fields[0] as int,
      pages: fields[1] as int,
      next: fields[2] as String?,
      prev: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ApiInfoDTO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.pages)
      ..writeByte(2)
      ..write(obj.next)
      ..writeByte(3)
      ..write(obj.prev);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiInfoDTO _$ApiInfoFromJson(Map<String, dynamic> json) => ApiInfoDTO(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String? ?? '',
      prev: json['prev'] as String? ?? '',
    );

Map<String, dynamic> _$ApiInfoToJson(ApiInfoDTO instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };