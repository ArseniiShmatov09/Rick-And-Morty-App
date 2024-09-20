import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/domain/entities/episode_entity.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';

part 'character_details_state.dart';
part 'character_details_event.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc() :
    super(const CharacterDetailsState()) {
       on<LoadCharacterDetails>(_load);
  }

  final EpisodeRepository
    _episodeRepository = GetIt.I<EpisodeRepository>();

  final CharacterRepository
    _characterRepository = GetIt.I<CharacterRepository>();

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

      final firstEpisodeUrl = character.episode!.first;
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