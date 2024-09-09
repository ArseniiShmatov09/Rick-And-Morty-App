// import 'dart:async';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rick_and_morty_app/domain/entities/character.dart';
// import 'package:rick_and_morty_app/domain/repositories/characters_list/characters_list_repository.dart';
//
// part 'character_list_state.dart';
// part 'character_list_event.dart';
//
// class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
//   final CharactersListRepository _repository;
//   int _currentPage = 1;
//   bool _hasMoreData = true;
//
//   CharacterListBloc(this._repository) : super(CharacterListInitial()) {
//     on<LoadCharacterList>(_onLoadCharacterList);
//     on<LoadFilteredCharacters>(_onLoadFilteredCharacters);
//   }
//
//   Future<void> _onLoadCharacterList(LoadCharacterList event, Emitter<CharacterListState> emit) async {
//     if (!_hasMoreData || state is CharacterListLoading) return;
//     emit(CharacterListLoading());
//
//     try {
//       final characters = await _repository.loadNextPage(_currentPage);
//       if (characters.isEmpty) {
//         _hasMoreData = false;
//       }
//       final currentCharacters = (state is CharacterListLoaded)
//           ? (state as CharacterListLoaded).charactersList
//           : <Character>[];
//       emit(CharacterListLoaded(charactersList: currentCharacters + characters, currentPage: _currentPage));
//       _currentPage++;
//     } catch (e) {
//       emit(CharacterListLoadingFailure(exception: e));
//     }
//   }
//
//   Future<void> _onLoadFilteredCharacters(LoadFilteredCharacters event, Emitter<CharacterListState> emit) async {
//     emit(CharacterListLoading());
//     _currentPage = 1;
//     _hasMoreData = true;
//
//     try {
//       final characters = await _repository.loadNextPage(_currentPage, status: event.status, species: event.species);
//       emit(CharacterListLoaded(charactersList: characters, currentPage: _currentPage));
//       _currentPage++;
//     } catch (e) {
//       emit(CharacterListLoadingFailure(exception: e));
//     }
//   }
// }
