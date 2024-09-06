import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';
part 'api_info.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class ApiInfo {

  @HiveField(0)
  final int count;
  @HiveField(1)
  final int pages;
  @HiveField(2)
  final String? next;
  @HiveField(3)
  final String? prev;

  ApiInfo({
    required this.count,
    required this.pages,
    this.next = '',
    this.prev = '',
  });

   factory ApiInfo.fromJson(Map<String, dynamic> json) =>
    _$ApiInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$ApiInfoToJson(this);

}