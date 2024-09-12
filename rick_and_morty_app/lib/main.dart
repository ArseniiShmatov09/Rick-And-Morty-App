import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import 'package:rick_and_morty_app/domain/repositories/theme_repository.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/presentation/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain/utils/app_initializer.dart';
import 'domain/utils/network_connection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appData = await initializeApp();

  runApp(
    MainApp(
      preferences: appData['preferences'],
      charactersBox: appData['charactersBox'],
      episodeBox: appData['episodesBox'],
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
    required this.preferences,
    required this.charactersBox,
    required this.episodeBox,
  })  : themeRepository = ThemeRepository(preferences: preferences),
        mainNavigation = MainNavigation(charactersBox, episodeBox),
        networkConnection = NetworkConnection();

  final SharedPreferences preferences;
  final Box<Character> charactersBox;
  final Box<Episode> episodeBox;
  final ThemeRepository themeRepository;
  final MainNavigation mainNavigation;
  final NetworkConnection networkConnection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(themeRepository: themeRepository),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            routes: mainNavigation.routes,
            initialRoute: networkConnection.isOffline
                ? MainNavigationRouteNames.offlineMode
                : MainNavigationRouteNames.mainScreen,
            onGenerateRoute: mainNavigation.onGenerateRoute,
          );
        },
      ),
    );
  }
}

