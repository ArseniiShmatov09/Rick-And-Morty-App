import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

import '../../domain/entities/episode.dart';

part 'character_delails_state.dart';
part 'character_delails_event.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc(this.charactersBox, this.episodesBox) : super(const CharacterDetailsState()) {
    _apiClient = ApiClient(charactersBox, episodesBox);
    on<LoadCharacterDetails>(_load);
  }

  late final ApiClient _apiClient;

  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;

  Future<void> _load(
      LoadCharacterDetails event,
      Emitter<CharacterDetailsState> emit,
      ) async {
    try {
      if (state is! CharacterDetailsLoaded) {
        emit(const CharacterDetailsLoading());
      }

      final characeterDetails =
        await _apiClient.getCharacter(event.characterId);

      emit(CharacterDetailsLoaded(characeterDetails));
    } catch (e, st) {
      emit(CharacterDetailsLoadingFailure(e));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}