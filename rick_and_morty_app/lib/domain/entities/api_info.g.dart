// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiInfo _$ApiInfoFromJson(Map<String, dynamic> json) => ApiInfo(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String? ?? '',
      prev: json['prev'] as String? ?? '',
    );

Map<String, dynamic> _$ApiInfoToJson(ApiInfo instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
