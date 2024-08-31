import 'package:json_annotation/json_annotation.dart';
part 'api_info.g.dart';

@JsonSerializable()
class ApiInfo {

  final int count;
  final int pages;
  final String? next;
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