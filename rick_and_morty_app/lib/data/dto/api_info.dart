// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/domain/entities/api_info_entity.dart';

part 'api_info.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class ApiInfoDTO extends ApiInfoEntity{

  @override
  @HiveField(0)
  final int count;

  @override
  @HiveField(1)
  final int pages;

  @override
  @HiveField(2)
  final String? next;

  @override
  @HiveField(3)
  final String? prev;

  ApiInfoDTO({
    required this.count,
    required this.pages,
    this.next = '',
    this.prev = '',
  }): super(
    count: count,
    pages: pages,
    next: next,
    prev: prev,
  );

   factory ApiInfoDTO.fromJson(Map<String, dynamic> json) =>
    _$ApiInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ApiInfoToJson(this);

}