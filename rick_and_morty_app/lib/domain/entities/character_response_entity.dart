import 'package:rick_and_morty_app/domain/entities/api_info_entity.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';

class CharactersResponseEntity {

  final ApiInfoEntity info;

  final List<CharacterEntity> characters;

  CharactersResponseEntity({
    required this.info,
    required this.characters
  });

  List<Object?> get props => [info, characters];
}