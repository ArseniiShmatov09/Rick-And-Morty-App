part of 'character_details_bloc.dart';

class CharacterDetailsState  {
  const CharacterDetailsState();

  @override
  List<Object?> get props => [];
}

class CharacterDetailsLoading extends CharacterDetailsState {
  const CharacterDetailsLoading();
}

class CharacterDetailsLoaded extends CharacterDetailsState {
  const CharacterDetailsLoaded(this.character, this.firstEpisode);

  final CharacterEntity character;
  final EpisodeEntity firstEpisode;

  @override
  List<Object?> get props => [character, firstEpisode];
}

class CharacterDetailsLoadingFailure extends CharacterDetailsState {
  const CharacterDetailsLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}