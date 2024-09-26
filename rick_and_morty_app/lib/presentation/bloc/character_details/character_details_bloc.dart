import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';
import 'package:rick_and_morty_app/domain/usecases/get_character.dart';
import 'package:rick_and_morty_app/domain/usecases/get_episode.dart';

part 'character_details_state.dart';
part 'character_details_event.dart';

class CharacterDetailsBloc
  extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
    CharacterDetailsBloc({
      required GetCharacter getCharacter,
      required GetEpisode getEpisode,
    }) : _getCharacter = getCharacter, _getEpisode = getEpisode,
    super(const CharacterDetailsState()) {
       on<LoadCharacterDetails>(_load);
  }

  final GetCharacter _getCharacter;
  final GetEpisode _getEpisode;

  Future<void> _load(
    LoadCharacterDetails event,
    Emitter<CharacterDetailsState> emit,
    ) async {

    try {
      if (state is! CharacterDetailsLoaded) {
        emit(const CharacterDetailsLoading());
      }

      final character =
        await _getCharacter(event.characterId);

      final firstEpisodeUrl = character.episode.first;
      final episodeId = firstEpisodeUrl.split('/').last;
      final firstEpisode = await _getEpisode(int.parse(episodeId));

      emit(CharacterDetailsLoaded(character, firstEpisode));

    } catch (e) {
      emit(CharacterDetailsLoadingFailure(e));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}