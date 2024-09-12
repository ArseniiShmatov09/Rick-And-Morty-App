import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import '../../../data/entities/episode.dart';
import '../../../domain/repositories/character_repository.dart';
import '../../../domain/repositories/episode_repository.dart';

part 'character_details_state.dart';
part 'character_details_event.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc(this.charactersBox, this.episodesBox) : super(const CharacterDetailsState()) {
    _apiClient = ApiClient(charactersBox, episodesBox);
    _characterRepository = CharacterRepository(charactersBox, _apiClient);
    _episodeRepository = EpisodeRepository(episodesBox, _apiClient);
    on<LoadCharacterDetails>(_load);
  }

  late final ApiClient _apiClient;
  late final EpisodeRepository _episodeRepository;
  late final CharacterRepository _characterRepository;

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

      final character =
        await _characterRepository.getCharacter(event.characterId);

      final firstEpisodeUrl = character?.episode.first;
      final episodeId = firstEpisodeUrl?.split('/').last;
      final firstEpisode = await _episodeRepository.getEpisode(int.parse(episodeId ?? ''));

      emit(CharacterDetailsLoaded(character, firstEpisode));

    } catch (e, st) {
      emit(CharacterDetailsLoadingFailure(e));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}