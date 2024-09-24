import 'package:rick_and_morty_app/domain/models/character_response_model.dart';

abstract class CharactersListRepository {
  Future<CharactersResponseModel> getAllCharacters(int page);
  Future<CharactersResponseModel> getFilteredCharacters(String? status, String? species, int page,);
}