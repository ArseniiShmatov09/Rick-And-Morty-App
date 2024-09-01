import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});
  static const List<String> status = <String>['Alive', 'Dead', 'unknown'];
  static const List<String> species = <String>['Alien', 'Human', 'Humanoid'];
  
  
  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  String chosenStatus = '';
  String chosenSpecies = '';
  @override
  void initState() {
    super.initState();
    context.read<CharactersListModel>().loadCharacters(1);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CharactersListModel>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DropdownMenu<String>(
                  hintText: "status",
                  onSelected: (String? value) => model.selectStatus,
                  dropdownMenuEntries: CharactersList.status
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ),
              Expanded(
                child: DropdownMenu<String>(
                  hintText: "species",
                  onSelected: (String? value) => model.selectSpecies,
                  dropdownMenuEntries: CharactersList.species
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ),
              FloatingActionButton(mini: true, onPressed: () => model.loadFilteredCharacters(model.selectedStatus, model.selectedSpecies, 1))
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 242, 242, 242),
            child: ListView.builder(
                itemCount: model.characters.length ?? 0,
                itemExtent: 150,
                itemBuilder: (BuildContext context, int index) {
                  final character = model.characters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 212, 212, 212),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Row(
                            children: [
                              Image.network(
                                character.image,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
