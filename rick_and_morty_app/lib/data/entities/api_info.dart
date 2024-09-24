// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'api_info.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class ApiInfoEntity {

  @HiveField(0)
  final int count;

  @HiveField(1)
  final int pages;

  @HiveField(2)
  final String? next;

  @HiveField(3)
  final String? prev;

  ApiInfoEntity({
    required this.count,
    required this.pages,
    this.next = '',
    this.prev = '',
  });

   factory ApiInfoEntity.fromJson(Map<String, dynamic> json) =>
    _$ApiInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ApiInfoToJson(this);

}