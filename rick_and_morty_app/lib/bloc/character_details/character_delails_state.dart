part of 'character_delails_bloc.dart';

class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();

  @override
  List<Object?> get props => [];
}

class CharacterDetailsLoading extends CharacterDetailsState {
  const CharacterDetailsLoading();
}

class CharacterDetailsLoaded extends CharacterDetailsState {
  const CharacterDetailsLoaded(this.character);

  final Character character;

  @override
  List<Object?> get props => [character];
}

class CharacterDetailsLoadingFailure extends CharacterDetailsState {
  const CharacterDetailsLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}