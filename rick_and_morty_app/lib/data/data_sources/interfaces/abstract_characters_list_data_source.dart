import '../../dto/characters_response.dart';

abstract class AbstractCharactersListDataSource {
  Future<CharactersResponseDTO> loadAllCharacters(int page);
  Future<CharactersResponseDTO> loadFilteredCharacters(
    String? status,
    String? species,
    int page,
  );
}