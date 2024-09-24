import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';

class CharacterDetailsInfoRowsWidget extends StatelessWidget {
  final CharacterModel? character;
  final EpisodeModel? firstEpisode;

  const CharacterDetailsInfoRowsWidget({
    super.key,
    required this.character,
    required this.firstEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Gender:', character?.gender ?? ''),
        _buildInfoRow('Origin:', character?.origin.name ?? ''),
        _buildInfoRow('Last known location:', character?.location.name ?? ''),
        _buildInfoRow('First seen in:', firstEpisode?.name ?? ''),
        _buildInfoRow('Type:', character?.type?.isEmpty ?? true ? 'Unknown' : character!.type!),
        _buildInfoRow('Created at:', character?.created ?? ''),
      ],
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
