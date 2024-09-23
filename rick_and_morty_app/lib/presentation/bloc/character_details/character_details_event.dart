part of 'character_details_bloc.dart';

sealed class CharacterDetailsEvent {
  const CharacterDetailsEvent();

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