import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import '../../../domain/models/character_model.dart';
import '../../../domain/usecases/get_all_characters.dart';
import '../../../domain/usecases/get_filtered_characters.dart';

part 'character_list_state.dart';
part 'character_list_event.dart';

class CharacterListBloc
    extends Bloc<CharacterListEvent, CharacterListState> {

  CharacterListBloc({
    required GetAllCharacters getAllCharacters,
    required GetFilteredCharacters getFilteredCharacters,
  }) : _getFilteredCharacters = getFilteredCharacters,
       _getAllCharacters = getAllCharacters,
    super(const CharacterListState()) {
      on<LoadCharacterList>(_loadAllCharacters);
      on<LoadFilteredCharacterList>(_loadFilteredCharacters);
      on<LoadNextPage>(loadNextPage);
    }

  final _characters = <CharacterModel>[];
  final GetAllCharacters _getAllCharacters;
  final GetFilteredCharacters _getFilteredCharacters;
  int currentPage = 1;
  int _pageCount = 1;

  String? _species;
  String? _status;

  bool _hasMoreData = true;

  Future<void> _loadAllCharacters(
    LoadCharacterList event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      if (state is! CharacterListLoaded) {
        emit(const CharacterListLoading());
      }
      await _setup();

      emit(CharacterListLoaded(List.from(_characters), _hasMoreData));
    } catch (e) {
      emit(CharacterListLoadingFailure(e));
    }
  }

  Future<void> _loadFilteredCharacters(
      LoadFilteredCharacterList event,
      Emitter<CharacterListState> emit,
      ) async {
    try {
      if (state is! CharacterListLoaded) {
        emit(const CharacterListLoading());
      }
      _status = event.status;
      _species = event.species;
      await _setup();

      emit(CharacterListLoaded(_characters, _hasMoreData));

    } catch (e) {
      emit(CharacterListLoadingFailure(e));
    }
  }

  Future<void> _setup() async {
    currentPage = 1;
    _pageCount = 1;
    _characters.clear();
    if ( currentPage > _pageCount) return;

    try {
      final charactersResponse = await _loadCharacters(currentPage);
      _characters.addAll(charactersResponse.characters);
      _pageCount = charactersResponse.info.pages;
      _hasMoreData = currentPage < _pageCount;
      currentPage++;
    } catch (e) {
      _hasMoreData = false;
    }
  }

  Future<CharactersResponseModel> _loadCharacters(int nextPage) async {
    if (_status == 'All') {
      _status = null;
    }
    if (_species == 'All') {
      _species = null;
    }
    if (_status == null && _species == null) {
      return await _getAllCharacters(nextPage);
    } else {
      return await _getFilteredCharacters(_status, _species, nextPage);
    }
  }

  Future<void> loadNextPage(
      LoadNextPage event,
      Emitter<CharacterListState> emit,
      ) async {
    if ( currentPage > _pageCount) {
      _hasMoreData = false;
    }

    try {
      final charactersResponse = await _loadCharacters(currentPage);
      _characters.addAll(charactersResponse.characters);
      _pageCount = charactersResponse.info.pages;
      _hasMoreData = currentPage < _pageCount;
      currentPage++;
      emit(CharacterListLoaded(List.from(_characters), _hasMoreData));
    } catch (e) {
      _hasMoreData = false;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

}