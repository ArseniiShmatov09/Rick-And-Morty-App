import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty_app/domain/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

import '../../../domain/entities/episode.dart';
import '../../../domain/models/network_connection.dart';

class CharacterDetails extends StatefulWidget {

  const CharacterDetails({Key? key,
    required this.charactersBox,
    required this.episodesBox,
    required this.characterId
  }) : super(key: key);

  final Box<Character> charactersBox;
  final Box<Episode> episodesBox;
  final int characterId;

  @override
  State<CharacterDetails> createState() =>
      _CharacterDetailsState(
        charactersBox,
        episodesBox,
      );
}

class _CharacterDetailsState extends State<CharacterDetails> {
  _CharacterDetailsState(
    this.charactersBox,
    this.episodesBox
  ){
    _characterDetailsBloc = CharacterDetailsBloc(charactersBox, episodesBox);
  }
  final networkConnection = NetworkConnection();

  late final Box<Character> charactersBox;
  late final Box<Episode> episodesBox;

  late final CharacterDetailsBloc _characterDetailsBloc;
  @override
  void initState() {
    super.initState();
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
            if (state is CharacterDetailsLoaded) {
              return Text(state.character?.name ?? 'Character Details');
            }
            return const Text('');
          },
        ),
      ),
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        bloc: _characterDetailsBloc,
        builder: (context, state) {
          if (state is CharacterDetailsLoading) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.grey,
              )
            );
          }
          if (state is CharacterDetailsLoaded) {
            final character = state.character;
            final firstEpisode = state.firstEpisode;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: networkConnection.isOffline ?
                        Image.asset(
                          'assets/images/no_image.jpeg',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,) :
                        Image.network(
                          character?.image ?? '',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )

                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      character?.name ?? '',
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${character?.status} - ${character?.species}',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const Divider(height: 30, color: Colors.black54),
                  _buildInfoRow('Gender:', character?.gender ?? ''),
                  _buildInfoRow('Origin:', character?.origin.name ?? ''),
                  _buildInfoRow('Location:', character?.location.name ?? ''),
                  _buildInfoRow('Episodes:', firstEpisode?.name ?? ''),
                  _buildInfoRow('Type:', character.type == '' ? 'Unknown' : character.type!),

                ],
              ),
            );
          }
          return Center(child: Text('No available data'));
        }
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
