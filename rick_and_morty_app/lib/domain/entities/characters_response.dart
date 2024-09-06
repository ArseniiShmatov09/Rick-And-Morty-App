import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/domain/entities/api_info.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:hive_flutter/adapters.dart';
part 'characters_response.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class CharactersResponse {

  @HiveField(0)
  final ApiInfo info;

  @HiveField(1)
  @JsonKey(name: 'results')
  late List<Character> characters;

  CharactersResponse({
    required this.info,
    required this.characters
  });

   factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
    _$CharactersResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}