part of 'character_list_bloc.dart';

class CharacterListState {
  const CharacterListState();

  List<Object?> get props => [];
}

class CharacterListLoading extends CharacterListState {
  const CharacterListLoading();
}

class CharacterListLoaded extends CharacterListState {
  const CharacterListLoaded(this.characters, this.hasMoreData);

  final List<CharacterModel> characters;
  final bool hasMoreData;
  @override
  List<Object?> get props => [characters, hasMoreData];
}

class CharacterListLoadingFailure extends CharacterListState {
  const CharacterListLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => super.props..add(exception);
}