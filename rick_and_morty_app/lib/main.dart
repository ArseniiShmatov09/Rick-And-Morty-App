import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/pages/characters%20list/characters_list.dart';
import 'package:rick_and_morty_app/pages/settings/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          surfaceTintColor: const Color.fromRGBO(48, 27, 40, 1),
          backgroundColor: const Color.fromRGBO(48, 27, 40, 1),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_list,), iconSize: 35,)
          ],
          
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromRGBO(48, 27, 40, 1),
          destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'All characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),

          ],
        ),
        //body: SettingsPage(),
        body: CharactersList(),
      ),
    );
  }
}
