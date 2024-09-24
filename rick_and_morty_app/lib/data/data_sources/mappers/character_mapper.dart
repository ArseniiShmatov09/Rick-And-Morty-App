import '../../../domain/models/character_model.dart';
import '../../entities/character.dart';

class  CharacterMapper  {
  final LocationInfoMapper _locationInfoMapper = LocationInfoMapper();
  CharacterModel toModel (CharacterEntity entity) => CharacterModel (
    id: entity.id,
    name: entity.name,
    status: entity.status,
    species: entity.species,
    type: entity.type,
    gender: entity.gender,
    origin: _locationInfoMapper.toModel(entity.origin),
    location: _locationInfoMapper.toModel(entity.location),
    episode: entity.episode,
    url: entity.url,
    image: entity.image,
    created: entity.created,
  );

  CharacterEntity fromModel (CharacterModel model) => CharacterEntity (
    id: model.id,
    name: model.name,
    status: model.status,
    species: model.species,
    type: model.type,
    gender: model.gender,
    origin: _locationInfoMapper.fromModel(model.origin),
    location: _locationInfoMapper.fromModel(model.origin),
    episode: model.episode,
    url: model.url,
    image: model.image,
    created: model.created,
  );
}

class LocationInfoMapper {
  LocationInfoModel toModel (LocationInfoEntity entity) => LocationInfoModel (
    name: entity.name,
    url: entity.url,
  );

  LocationInfoEntity fromModel (LocationInfoModel model) => LocationInfoEntity (
    name: model.name,
    url: model.url,
  );
}