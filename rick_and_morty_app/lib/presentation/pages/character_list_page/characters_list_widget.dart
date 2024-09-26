import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty_app/presentation/pages/character_list_page/character_filter_section_widget.dart';
import 'package:rick_and_morty_app/presentation/pages/character_list_page/character_list_item_widget.dart';
import 'package:rick_and_morty_app/presentation/widgets/loading_indicator_widget.dart';
import '../../../domain/utils/network_connection.dart';
import '../../navigation/main_navigation.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final controller = ScrollController();
  String selectedStatus = '';
  String selectedSpecies = '';
  final networkConnection = NetworkConnection();

  @override
  void initState() {
    super.initState();
    context.read<CharacterListBloc>().add(const LoadCharacterList(page: 1));
    controller.addListener(()
      {
        if (controller.position.maxScrollExtent == controller.offset) {
          context.read<CharacterListBloc>().add(const LoadNextPage());
        }
      }
    );
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
    final isOffline = networkConnection.isOffline;
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state is CharacterListLoading) {
          return const LoadingIndicatorWidget();
        }
        if (state is CharacterListLoaded) {
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
                  context.read<CharacterListBloc>().add(
                     LoadFilteredCharacterList(
                      page: 1,
                      status: selectedStatus,
                      species: selectedSpecies
                    )
                  );
                },
              ),
              Expanded(
                child: state.characters.isEmpty
                    ? const Center(child: Text('No available data'))
                    : ListView.builder(
                  controller: controller,
                  itemCount: state.characters.length +
                      (state.hasMoreData ? 1 : 0),
                  itemExtent: 150,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.characters.length) {
                      final character = state.characters[index];
                      return CharacterListItemWidget(
                        character: character,
                          isOffline: isOffline,
                        onTap: () => {
                          Navigator.of(context).pushNamed(
                            MainNavigationRouteNames.characterDetails,
                            arguments: character.id,
                          ),
                        }
                      );
                    } else {
                      return state.hasMoreData
                          ? const LoadingIndicatorWidget()
                          : const SizedBox(height: 0);
                    }
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('No available data'));
      }
    );
  }
}
