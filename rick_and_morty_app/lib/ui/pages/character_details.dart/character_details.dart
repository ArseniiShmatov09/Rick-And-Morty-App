import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/bloc/character_details/character_delails_bloc.dart';
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
    _characeterDetailsBloc = CharacterDetailsBloc(charactersBox, episodesBox);
  }
  final networkConnection = NetworkConnection();

  late final Box<Character> charactersBox;
  late final Box<Episode> episodesBox;

  late final CharacterDetailsBloc _characeterDetailsBloc;
  @override
  void initState() {
    super.initState();
    _characeterDetailsBloc.add(LoadCharacterDetails(characterId: widget.characterId));
  }

  @override
  Widget build(BuildContext context) {
    //final model = context.watch<CharacterModel>();

    //final character = model.character;


    //String? characterType = model.character?.type;
   // if(characterType == '' || characterType == null){ characterType = 'unknown';}

    // if (model.isLoadInprogress) {
    //   return const Center(
    //     child: SpinKitFadingCircle(
    //       color: Colors.grey,
    //     ),
    //   );
    // }

    // if (character == null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Unknown Character'),
    //       backgroundColor: const Color.fromARGB(222, 145, 140, 140),
    //     ),
    //     body: const Center(
    //       child: Text('No available data'),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        //title: Text(model.character?.name ?? 'Unknown'),
        backgroundColor: Color.fromARGB(222, 145, 140, 140),

    ),
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        bloc: _characeterDetailsBloc,
        builder: (context, state) {
          if (state is CharacterDetailsLoaded) {
            final character = state.character;
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
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                  //_buildInfoRow('Episodes:', model.firstEpisode?.name ?? ''),
                  //_buildInfoRow('Created at:', model.formattedDateOfCreation?? ''),

                  //_buildInfoRow('Type:', characterType)

                ],
              ),
            );

          }
          return const Center(child: CircularProgressIndicator());
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
