import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

 class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(48, 27, 40, 30),
      child: ListView.builder(
        itemCount: 10,
        itemExtent: 150,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              color: const Color.fromRGBO(221, 197, 162, 1),
              child: const Row(
                children: [
                  Text("data"),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          );
        }
      ),
    );    
  }
}