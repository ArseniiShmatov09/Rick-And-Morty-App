part of 'character_list_bloc.dart';

sealed class CharacterListEvent {
  const CharacterListEvent();

  List<Object> get props => [];
}

class LoadCharacterList extends CharacterListEvent {
  const LoadCharacterList({
    required this.page,
  });

  final int page;

  @override
  List<Object> get props => super.props..add(page);
}

class LoadFilteredCharacterList extends CharacterListEvent {
  const LoadFilteredCharacterList({
    required this.page,
    required this.status,
    required this.species,
  });

  final int page;
  final String? status;
  final String? species;

  @override
  List<Object> get props => super.props..add([page, status, species]);
}

class LoadNextPage extends CharacterListEvent {
  const LoadNextPage();

  @override
  List<Object> get props => [];
}