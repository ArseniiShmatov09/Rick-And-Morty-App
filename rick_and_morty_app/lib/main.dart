import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/ui/pages/character_details.dart/character_details.dart';
import 'package:rick_and_morty_app/ui/pages/characters_list/characters_list.dart';
import 'package:rick_and_morty_app/ui/pages/main_page/main_page.dart';
import 'package:rick_and_morty_app/ui/pages/settings/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
