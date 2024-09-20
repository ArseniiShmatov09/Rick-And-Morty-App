import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';

abstract class CharactersListRepository {
  Future<CharactersResponseEntity> getAllCharacters(int page);
  Future<CharactersResponseEntity> getFilteredCharacters(String? status, String? species, int page,);
}