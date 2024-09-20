import '../../data/dto/character.dart';

abstract class AbstractCharacterRepository {
  Future<CharacterDTO> getCharacter(int characterId);
}