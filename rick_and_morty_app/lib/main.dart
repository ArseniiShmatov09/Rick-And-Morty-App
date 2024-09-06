import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/domain/entities/api_info.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/characters_response.dart';
import 'package:rick_and_morty_app/domain/entities/episode.dart';
import 'package:rick_and_morty_app/domain/models/characters_list_model.dart';
import 'package:rick_and_morty_app/domain/repositories/settings/settings_repository.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/ui/pages/character_details.dart/character_details.dart';
import 'package:rick_and_morty_app/ui/pages/characters_list/characters_list.dart';
import 'package:rick_and_morty_app/ui/pages/main_page/main_page.dart';
import 'package:rick_and_morty_app/ui/pages/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/models/network_connection.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  const String charactersBoxName = 'characters_box';

  await Hive.initFlutter();

  Hive.registerAdapter(EpisodeAdapter());
  Hive.registerAdapter(ApiInfoAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(CharactersResponseAdapter());
  Hive.registerAdapter(LocationInfoAdapter());

  final charactersBox = await Hive.openBox<Character>(charactersBoxName);

  runApp(
    MainApp(
      preferences: prefs,
      charactersBox: charactersBox,
    )
  );
}

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
    required this.preferences,
    required this.charactersBox,
  });

  final SharedPreferences preferences;
  final Box<Character> charactersBox;
  final networkConnection = NetworkConnection();

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepository(preferences: preferences);
    final mainNavigation = MainNavigation(charactersBox);
    return  BlocProvider(
      create: (context) => ThemeCubit(settingsRepository: settingsRepository,),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {

         return MaterialApp(
          theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          routes: mainNavigation.routes,
           initialRoute: networkConnection.isOffline ?
             MainNavigationRouteNames.offlineMode
             : MainNavigationRouteNames.mainScreen,
          onGenerateRoute: mainNavigation.onGenerateRoute,
         );
        }
      ),
    );
  }
}
