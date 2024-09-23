import 'package:rick_and_morty_app/data/data_sources/mappers/api_info_mapper.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/character_mapper.dart';
import 'package:rick_and_morty_app/data/dto/characters_response.dart';
import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';

class  CharactersResponseMapper  {

  final ApiInfoMapper _apiInfoMapper = ApiInfoMapper();
  final CharacterMapper _characterMapper = CharacterMapper();

  CharactersResponseEntity toEntity (CharactersResponseDTO dto) => CharactersResponseEntity (
    info: dto.info,
    characters: dto.characters.map(_characterMapper.toEntity).toList(),
  );

  CharactersResponseDTO fromEntity (CharactersResponseEntity entity) => CharactersResponseDTO (
    info: _apiInfoMapper.fromEntity(entity.info),
    characters: entity.characters.map(_characterMapper.fromEntity).toList(),
  );
}
