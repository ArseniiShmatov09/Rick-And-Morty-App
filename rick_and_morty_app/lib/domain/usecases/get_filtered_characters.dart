import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';

import '../repositories/characters_list_repository.dart';

class GetFilteredCharacters {
  GetFilteredCharacters({
    required CharactersListRepository repository,
  }) : _repository = repository;

  final CharactersListRepository _repository;

  Future<CharactersResponseEntity> call(String? status, String? species, int page) async {
    final list = await _repository.getFilteredCharacters(status, species, page);
    return list;
  }
}