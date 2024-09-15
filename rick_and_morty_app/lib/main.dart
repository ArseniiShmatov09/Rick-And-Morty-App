import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';
import 'package:rick_and_morty_app/presentation/theme/theme.dart';
import 'domain/interfaces/abstract_theme_repository.dart';
import 'domain/utils/app_initializer.dart';
import 'domain/utils/network_connection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
  })  : themeRepository = GetIt.I<AbstractThemeRepository>(),
        mainNavigation = MainNavigation(),
        networkConnection = NetworkConnection();

  final AbstractThemeRepository themeRepository;
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

