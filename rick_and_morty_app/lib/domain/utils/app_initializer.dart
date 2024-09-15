import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_character_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_episode_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_theme_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/data/entities/character.dart';
import 'package:rick_and_morty_app/data/entities/episode.dart';
import '../../data/entities/api_info.dart';
import '../../data/entities/characters_response.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(EpisodeAdapter());
  Hive.registerAdapter(ApiInfoAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(CharactersResponseAdapter());
  Hive.registerAdapter(LocationInfoAdapter());
}

void initializeGetIt(
  Box<Character> charactersBox,
  Box<Episode> episodesBox,
  SharedPreferences prefs,
  ) {
  GetIt.I.registerLazySingleton<AbstractCharactersListRepository>(
        () => CharactersListRepository(
        ApiClient(
            charactersBox,
            episodesBox
        )
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCharacterRepository>(
        () => CharacterRepository(
        ApiClient(
            charactersBox,
            episodesBox
        )
    ),
  );

  GetIt.I.registerLazySingleton<AbstractEpisodeRepository>(
        () => EpisodeRepository(
        ApiClient(
            charactersBox,
            episodesBox
        )
    ),
  );

  GetIt.I.registerLazySingleton<AbstractThemeRepository>(
    () => ThemeRepository(preferences: prefs),
  );
}

Future<void> initializeApp() async {

  await initializeHive();
  final prefs = await SharedPreferences.getInstance();

  const String charactersBoxName = 'characters_box';
  const String episodesBoxName = 'episodes_box';

  final charactersBox = await Hive.openBox<Character>(charactersBoxName);
  final episodesBox = await Hive.openBox<Episode>(episodesBoxName);

  initializeGetIt(charactersBox, episodesBox, prefs);

}

