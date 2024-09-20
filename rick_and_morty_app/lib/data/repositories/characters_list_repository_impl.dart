import 'package:rick_and_morty_app/domain/entities/character_response_entity.dart';

import '../../domain/repositories/characters_list_repository.dart';
import '../data_sources/interfaces/abstract_characters_list_data_source.dart';

class CharactersListRepositoryImpl implements CharactersListRepository {

  final AbstractCharactersListDataSource _abstractCharactersListDataSource;

  CharactersListRepositoryImpl({
    required AbstractCharactersListDataSource abstractCharactersListDataSource,
  })  : _abstractCharactersListDataSource = abstractCharactersListDataSource;


  @override
  Future<CharactersResponseEntity> getAllCharacters(int page) {
    return _abstractCharactersListDataSource.loadAllCharacters(page);
  }

  @override
  Future<CharactersResponseEntity> getFilteredCharacters(String? status, String? species, int page) {
    return _abstractCharactersListDataSource.loadFilteredCharacters(status, species, page);
  }
}