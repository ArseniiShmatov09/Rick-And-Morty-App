part of 'character_delails_bloc.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacterDetails extends CharacterDetailsEvent {
  const LoadCharacterDetails({
    required this.characterId,
  });

  final int characterId;

  @override
  List<Object> get props => super.props..add(characterId);
}