import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';

class HeaderDetailsInfoWidget extends StatelessWidget {
  final Character? character;
  final NetworkConnection networkConnection;

  const HeaderDetailsInfoWidget({
    super.key,
    required this.character,
    required this.networkConnection,
  });

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
          style: TextStyle(fontSize: 18, color: AppColors.mainGrey),
        ),
      ],
    );
  }
}
