import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'api_info.dart';
import 'character.dart';

part 'characters_response.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class CharactersResponseDTO {

  @HiveField(0)
  final ApiInfoDTO info;

  @HiveField(1)
  @JsonKey(name: 'results')
  late List<CharacterDTO> characters;

  CharactersResponseDTO({
    required this.info,
    required this.characters
  });

   factory CharactersResponseDTO.fromJson(Map<String, dynamic> json) =>
    _$CharactersResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}