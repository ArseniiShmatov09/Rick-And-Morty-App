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
        InfoRow(title: 'Gender:', value: character?.gender ?? ''),
        InfoRow(title: 'Origin:', value: character?.origin.name ?? ''),
        InfoRow(title: 'Last known location:', value: character?.location.name ?? ''),
        InfoRow(title: 'First seen in:', value: firstEpisode?.name ?? ''),
        InfoRow(title: 'Type:', value: character?.type?.isEmpty ?? true ? 'Unknown' : character!.type!),
        InfoRow(title: 'Created at:', value: character?.created ?? ''),
      ],
    );
  }

}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
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

