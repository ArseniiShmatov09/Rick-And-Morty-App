import '../../../domain/entities/character_entity.dart';
import '../../dto/character.dart';

class  CharacterMapper  {
  final LocationInfoMapper _locationInfoMapper = LocationInfoMapper();
  CharacterEntity toEntity (CharacterDTO dto) => CharacterEntity (
    id: dto.id,
    name: dto.name,
    status: dto.status,
    species: dto.species,
    type: dto.type,
    gender: dto.gender,
    origin: _locationInfoMapper.toEntity(dto.origin),
    location: _locationInfoMapper.toEntity(dto.location),
    episode: dto.episode,
    url: dto.url,
    image: dto.image,
    created: dto.created,
  );

  CharacterDTO fromEntity (CharacterEntity entity) => CharacterDTO (
    id: entity.id,
    name: entity.name,
    status: entity.status,
    species: entity.species,
    type: entity.type,
    gender: entity.gender,
    origin: _locationInfoMapper.fromEntity(entity.origin),
    location: _locationInfoMapper.fromEntity(entity.origin),
    episode: entity.episode,
    url: entity.url,
    image: entity.image,
    created: entity.created,
  );
}

class LocationInfoMapper {
  LocationInfoEntity toEntity (LocationInfoDTO dto) => LocationInfoEntity (
    name: dto.name,
    url: dto.url,
  );

  LocationInfoDTO fromEntity (LocationInfoEntity entity) => LocationInfoDTO (
    name: entity.name,
    url: entity.url,
  );
}