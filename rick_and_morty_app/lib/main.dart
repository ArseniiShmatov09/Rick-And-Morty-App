import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/bloc/theme/theme_state.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MainApp(
      preferences: prefs,
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key,
    required this.preferences,
  });

  final SharedPreferences preferences;
  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepository(
        preferences: preferences
    );
    return  BlocProvider(
      create: (context) => ThemeCubit(settingsRepository: settingsRepository,),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
         return MaterialApp(
          theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          routes: mainNavigation.routes,
          initialRoute: mainNavigation.initialRoute,
          onGenerateRoute: mainNavigation.onGenerateRoute,
         );
        }
      ),
    );
  }
}
