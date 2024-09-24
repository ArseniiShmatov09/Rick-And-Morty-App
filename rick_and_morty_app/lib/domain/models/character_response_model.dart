import 'package:rick_and_morty_app/domain/models/api_info_model.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

class CharactersResponseModel {

  final ApiInfoModel info;

  final List<CharacterModel> characters;

  CharactersResponseModel({
    required this.info,
    required this.characters
  });

  List<Object?> get props => [info, characters];
}