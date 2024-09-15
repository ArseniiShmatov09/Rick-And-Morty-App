// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/widgets/loading_indicator_widget.dart';
import 'character_details_info_rows_widget.dart';
import 'header_details_info_widget.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({
    super.key,
    required this.characterId,
  });

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
    _characterDetailsBloc = CharacterDetailsBloc();
    _characterDetailsBloc.add(LoadCharacterDetails(characterId: widget.characterId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainGrey,
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