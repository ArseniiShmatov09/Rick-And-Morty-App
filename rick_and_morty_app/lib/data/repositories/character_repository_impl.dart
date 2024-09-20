import 'package:rick_and_morty_app/domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../data_sources/interfaces/abstract_character_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {

  final AbstractCharacterDataSource _abstractCharacterDataSource;

  CharacterRepositoryImpl({
    required AbstractCharacterDataSource abstractCharacterDataSource,
  })  : _abstractCharacterDataSource = abstractCharacterDataSource;

  @override
  Future<CharacterEntity> getCharacter(int characterId) {
    return _abstractCharacterDataSource.loadCharacter(characterId);
  }
}