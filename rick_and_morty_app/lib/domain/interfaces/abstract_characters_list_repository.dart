import '../../data/dto/characters_response.dart';

abstract class AbstractCharactersListRepository {
  Future<CharactersResponseDTO> getAllCharacters(int page);
  Future<CharactersResponseDTO> getFilteredCharacters(
    String? status,
    String? species,
    int page,
  );
}