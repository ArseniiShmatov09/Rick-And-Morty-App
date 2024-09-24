import '../../entities/character.dart';

abstract class AbstractCharacterDataSource {
  Future<CharacterEntity> loadCharacter(int characterId);
}