import 'package:rick_and_morty_app/domain/models/character_model.dart';

abstract class CharacterRepository {
  Future<CharacterModel> getCharacter(int characterId);
}