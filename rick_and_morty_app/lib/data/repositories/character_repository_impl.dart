import 'package:rick_and_morty_app/data/data_sources/mappers/character_mapper.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../data_sources/interfaces/abstract_character_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {

  final AbstractCharacterDataSource _abstractCharacterDataSource;
  final CharacterMapper _characterMapper = CharacterMapper();

  CharacterRepositoryImpl({
    required AbstractCharacterDataSource abstractCharacterDataSource,
  })  : _abstractCharacterDataSource = abstractCharacterDataSource;

  @override
  Future<CharacterEntity> getCharacter(int characterId) async {
    final characterDTO = await _abstractCharacterDataSource.loadCharacter(characterId);
    return _characterMapper.toEntity(characterDTO);
  }
}