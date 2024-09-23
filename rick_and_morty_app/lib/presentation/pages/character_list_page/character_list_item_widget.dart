// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';

class CharacterListItemWidget extends StatelessWidget {
  final CharacterEntity character;
  final bool isOffline;
  final VoidCallback onTap;

  const CharacterListItemWidget({
    Key? key,
    required this.character,
    required this.isOffline,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.mainGrey,
              border: Border.all(color: AppColors.mainBlack),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                isOffline
                    ? Image.asset('assets/images/no_image.jpeg')
                    : Image.network(character.image),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          character.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.mainLightGray,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${character.status} - ${character.species}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.mainBlack,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}