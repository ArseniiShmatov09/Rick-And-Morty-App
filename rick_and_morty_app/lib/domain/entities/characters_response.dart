import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/domain/entities/api_info.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

part 'characters_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CharactersResponse {
  final ApiInfo info;
  @JsonKey(name: 'results')
  final List<Character> characters;

  CharactersResponse({
    required this.info, 
    required this.characters
  });

   factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
    _$CharactersResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}