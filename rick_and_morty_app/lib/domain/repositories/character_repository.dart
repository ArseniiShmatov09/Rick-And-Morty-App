import 'package:rick_and_morty_app/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<CharacterEntity> getCharacter(int characterId);
}