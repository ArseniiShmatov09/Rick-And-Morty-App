import 'package:rick_and_morty_app/domain/models/character_response_model.dart';

import '../repositories/characters_list_repository.dart';

class GetFilteredCharacters {
  GetFilteredCharacters({
    required CharactersListRepository repository,
  }) : _repository = repository;

  final CharactersListRepository _repository;

  Future<CharactersResponseModel> call(String? status, String? species, int page) async {
    final list = await _repository.getFilteredCharacters(status, species, page);
    return list;
  }
}