import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';

import '../repositories/characters_list_repository.dart';

class GetAllCharacters {
  GetAllCharacters({
    required CharactersListRepository repository,
  }) : _repository = repository;

  final CharactersListRepository _repository;

  Future<CharactersResponseEntity> call(int page) async {
    final list = await _repository.getAllCharacters(page);
    return list;
  }
}