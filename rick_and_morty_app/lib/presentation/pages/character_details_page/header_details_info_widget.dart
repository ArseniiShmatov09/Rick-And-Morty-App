import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';

class HeaderDetailsInfoWidget extends StatelessWidget {
  final Character? character;
  final NetworkConnection networkConnection;

  const HeaderDetailsInfoWidget({
    Key? key,
    required this.character,
    required this.networkConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: networkConnection.isOffline
                ? Image.asset(
              'assets/images/no_image.jpeg',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            )
                : Image.network(
              character?.image ?? '',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            character?.name ?? '',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${character?.status} - ${character?.species}',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
