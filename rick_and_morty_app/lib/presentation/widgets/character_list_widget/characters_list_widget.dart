import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/models/characters_list_model.dart';
import 'package:rick_and_morty_app/presentation/widgets/character_list_widget/character_filter_section_widget.dart';
import 'package:rick_and_morty_app/presentation/widgets/character_list_widget/character_list_item_widget.dart';
import 'package:rick_and_morty_app/presentation/widgets/loading_indicator_widget.dart';
import '../../../domain/utils/network_connection.dart';

class CharactersListWidget extends StatefulWidget {
  const CharactersListWidget({super.key});

  @override
  State<CharactersListWidget> createState() => _CharactersListWidgetState();
}

class _CharactersListWidgetState extends State<CharactersListWidget> {
  final controller = ScrollController();
  String selectedStatus = '';
  String selectedSpecies = '';
  final networkConnection = NetworkConnection();

  @override
  void initState() {
    super.initState();
    context.read<CharactersListModel>().setup();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<CharactersListModel>().loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    Future.delayed(
      const Duration(milliseconds: 300),
          () {
        controller.jumpTo(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CharactersListModel>();
    final isOffline = networkConnection.isOffline;

    if (model.characters.isEmpty) {
      return const LoadingIndicatorWidget();
    }

    return Column(
      children: [
        CharacterFilterSectionWidget(
          selectedStatus: selectedStatus,
          selectedSpecies: selectedSpecies,
          onStatusChanged: (value) {
            setState(() {
              selectedStatus = value ?? '';
            });
          },
          onSpeciesChanged: (value) {
            setState(() {
              selectedSpecies = value ?? '';
            });
          },
          isOffline: isOffline,
          onSearchPressed: () {
            _scrollToTop();
            model.loadFilteredCharacters(
              selectedStatus,
              selectedSpecies,
              1,
            );
          },
        ),
        Expanded(
          child: model.characters.isEmpty
          ? const Center(child: Text('No available data'))
          : ListView.builder(
              controller: controller,
              itemCount: model.characters.length + (model.hasMoreData ? 1 : 0),
              itemExtent: 150,
              itemBuilder: (BuildContext context, int index) {
                if (index < model.characters.length) {
                  final character = model.characters[index];
                  return CharacterListItemWidget(
                    character: character,
                    isOffline: isOffline,
                    onTap: () => model.onCharacterTap(context, index),
                  );
                } else {
                  return model.hasMoreData
                    ? const LoadingIndicatorWidget()
                    : const SizedBox(height: 0);
                  }
              },
            ),
        ),
      ],
    );
  }
}
