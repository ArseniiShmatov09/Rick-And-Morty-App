import 'package:flutter/material.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});
  static const List<String> list = <String>['aldasl', 'Two', 'Three', 'Four'];
  //final model = NotifierProvider
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownMenu<String>(
                hintText: "status",
                onSelected: (String? value) {},
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
             
              DropdownMenu<String>(
                hintText: "species",
                onSelected: (String? value) {},
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 242, 242, 242),
            child: ListView.builder(
                itemCount: 10,
                itemExtent: 150,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Container(
                      color: Color.fromARGB(255, 212, 212, 212),
                      child: const Row(
                        children: [
                          Text("sasdsfdsda"),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
