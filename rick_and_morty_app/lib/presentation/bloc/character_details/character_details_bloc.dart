import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_episode_repository.dart';
import '../../../data/entities/episode.dart';
import '../../../domain/interfaces/abstract_character_repository.dart';

part 'character_details_state.dart';
part 'character_details_event.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc() :
    super(const CharacterDetailsState()) {
       on<LoadCharacterDetails>(_load);
  }

  final AbstractEpisodeRepository
    _episodeRepository = GetIt.I<AbstractEpisodeRepository>();

  final AbstractCharacterRepository
    _characterRepository = GetIt.I<AbstractCharacterRepository>();

  Future<void> _load(
    LoadCharacterDetails event,
    Emitter<CharacterDetailsState> emit,
    ) async {

    try {
      if (state is! CharacterDetailsLoaded) {
        emit(const CharacterDetailsLoading());
      }

      final character =
        await _characterRepository.getCharacter(event.characterId);

      final firstEpisodeUrl = character.episode.first;
      final episodeId = firstEpisodeUrl.split('/').last;
      final firstEpisode = await _episodeRepository.getEpisode(int.parse(episodeId));

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