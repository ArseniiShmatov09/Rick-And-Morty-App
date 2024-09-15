import '../../data/entities/character.dart';

abstract class AbstractCharacterRepository {
  Future<Character> getCharacter(int characterId);
}