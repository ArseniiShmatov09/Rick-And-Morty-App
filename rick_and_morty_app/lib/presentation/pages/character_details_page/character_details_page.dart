import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/widgets/loading_indicator_widget.dart';
import 'character_details_info_rows_widget.dart';
import 'header_details_info_widget.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({
    super.key,
    required this.charactersBox,
    required this.episodesBox,
    required this.characterId,
  });

  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;
  final int characterId;

  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  late final CharacterDetailsBloc _characterDetailsBloc;
  final networkConnection = NetworkConnection();

  @override
  void initState() {
    super.initState();
    _characterDetailsBloc = CharacterDetailsBloc(widget.charactersBox, widget.episodesBox);
    _characterDetailsBloc.add(LoadCharacterDetails(characterId: widget.characterId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 145, 140, 140),
        title: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          bloc: _characterDetailsBloc,
          builder: (context, state) {
            return Text(
              state is CharacterDetailsLoaded
                  ? state.character.name
                  : '',
            );
          },
        ),
      ),
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        bloc: _characterDetailsBloc,
        builder: (context, state) {
          if (state is CharacterDetailsLoading) {
            return const LoadingIndicatorWidget();
          }
          if (state is CharacterDetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderDetailsInfoWidget(
                    character: state.character,
                    networkConnection: networkConnection,
                  ),
                  const SizedBox(height: 16),
                  CharacterDetailsInfoRowsWidget(
                    character: state.character,
                    firstEpisode: state.firstEpisode,
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No available data'));
        },
      ),
    );
  }
}