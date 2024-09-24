import 'package:rick_and_morty_app/data/data_sources/mappers/api_info_mapper.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/character_mapper.dart';
import 'package:rick_and_morty_app/data/entities/characters_response.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';

class  CharactersResponseMapper  {

  final ApiInfoMapper _apiInfoMapper = ApiInfoMapper();
  final CharacterMapper _characterMapper = CharacterMapper();

  CharactersResponseModel toModel (CharactersResponseEntity entity) => CharactersResponseModel (
    info: _apiInfoMapper.toModel(entity.info),
    characters: entity.characters.map(_characterMapper.toModel).toList(),
  );

  CharactersResponseEntity fromModel (CharactersResponseModel model) => CharactersResponseEntity (
    info: _apiInfoMapper.fromModel(model.info),
    characters: model.characters.map(_characterMapper.fromModel).toList(),
  );
}
