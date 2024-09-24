import '../../entities/characters_response.dart';

abstract class AbstractCharactersListDataSource {
  Future<CharactersResponseEntity> loadAllCharacters(int page);
  Future<CharactersResponseEntity> loadFilteredCharacters(
    String? status,
    String? species,
    int page,
  );
}