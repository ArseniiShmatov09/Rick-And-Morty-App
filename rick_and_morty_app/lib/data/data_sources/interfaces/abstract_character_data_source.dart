import '../../dto/character.dart';

abstract class AbstractCharacterDataSource {
  Future<CharacterDTO> loadCharacter(int characterId);
}