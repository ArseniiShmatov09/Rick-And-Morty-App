import 'package:rick_and_morty_app/domain/models/character_model.dart';
import '../repositories/character_repository.dart';

class GetCharacter {
  GetCharacter({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  Future<CharacterModel> call(int characterId) async {
    return await _characterRepository.getCharacter(characterId);
  }
}