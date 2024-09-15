import '../../data/entities/characters_response.dart';

abstract class AbstractCharactersListRepository {
  Future<CharactersResponse> getAllCharacters(int page);
  Future<CharactersResponse> getFilteredCharacters(
    String? status,
    String? species,
    int page,
  );
}