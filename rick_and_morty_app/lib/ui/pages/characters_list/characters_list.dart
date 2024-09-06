import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';

import '../../../domain/models/network_connection.dart';
import '../../navigation/main_navigation.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});
  static const List<String> status = <String>['Alive', 'Dead', 'unknown'];
  static const List<String> species = <String>['Alien', 'Human', 'Humanoid'];

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
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
    Future.delayed(Duration(milliseconds: 300), () {
      controller.jumpTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CharactersListModel>();
    if (model.characters.length == 0) {
      return const Center(
        child: SpinKitFadingCircle(
          color: Colors.grey,
        ),
      );
    }

    return Column(
      children: [
        if(!networkConnection.isOffline)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownMenu<String>(
                  hintText: "status",
                  onSelected: (String? value) => {
                    value == null
                        ? selectedStatus = ''
                        : selectedStatus = value,
                  },
                  dropdownMenuEntries: CharactersList.status
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
              Expanded(
                child: DropdownMenu<String>(
                  hintText: "species",
                  onSelected: (String? value) => {
                    value == null
                        ? selectedSpecies = ''
                        : selectedSpecies = value,
                  },
                  dropdownMenuEntries: CharactersList.species
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        if(!networkConnection.isOffline)
        FloatingActionButton(
          onPressed: () {
            _scrollToTop();
            model.loadFilteredCharacters(
              selectedStatus,
              selectedSpecies,
              1,
            );
          },
          child: Icon(Icons.search),
        ),
        Expanded(
          child: Container(
            //color: Color.fromARGB(255, 242, 242, 242),

            child: model.characters.length == 0 ?
            Center(child: Text("No data available")) :
            ListView.builder(
                controller: controller,
                itemCount: model.characters.length ?? 0,
                itemExtent: 150,
                itemBuilder: (BuildContext context, int index) {
                  final character = model.characters[index];
                  if (index < model.characters.length - 1) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(222, 185, 184, 184),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Row(
                              children: [
                                networkConnection.isOffline?
                                Image.asset('assets/images/no_image.jpeg')
                                  : Image.network(
                                    character.image,
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          character.name,
                                          style: TextStyle(
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${character.status} - ${character.species}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => model.onCharacterTap(context, index),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return model.hasMoreData
                        ? Center(
                        child: SpinKitFadingCircle(
                          color: Colors.grey,
                        ))
                        : SizedBox(
                      height: 0,
                    );
                  }
                }),
          ),
        ),
      ],
    );
  }
}

