import 'package:rick_and_morty_app/data/data_sources/mappers/characters_response_mapper.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import '../../domain/repositories/characters_list_repository.dart';
import '../data_sources/interfaces/abstract_characters_list_data_source.dart';

class CharactersListRepositoryImpl implements CharactersListRepository {

  final AbstractCharactersListDataSource _abstractCharactersListDataSource;
  final CharactersResponseMapper _charactersResponseMapper = CharactersResponseMapper();
  
  CharactersListRepositoryImpl({
    required AbstractCharactersListDataSource abstractCharactersListDataSource,
  })  : _abstractCharactersListDataSource = abstractCharactersListDataSource;

  @override
  Future<CharactersResponseModel> getAllCharacters(int page) async {
    final charactersDTO = await _abstractCharactersListDataSource.loadAllCharacters(page);
    return _charactersResponseMapper.toModel(charactersDTO);
  }

  @override
  Future<CharactersResponseModel> getFilteredCharacters(String? status, String? species, int page) async {
    final charactersDTO = await _abstractCharactersListDataSource.loadFilteredCharacters(status, species, page);
    return _charactersResponseMapper.toModel(charactersDTO);
  }
}