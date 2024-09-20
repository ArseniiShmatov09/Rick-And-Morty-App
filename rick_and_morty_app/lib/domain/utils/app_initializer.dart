import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_character_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_episode_repository.dart';
import 'package:rick_and_morty_app/domain/interfaces/abstract_theme_repository.dart';
import 'package:rick_and_morty_app/data/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/data/repositories/episode_repository.dart';
import 'package:rick_and_morty_app/data/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/data/dto/character.dart';
import 'package:rick_and_morty_app/data/dto/episode.dart';
import '../../data/dto/api_info.dart';
import '../../data/dto/characters_response.dart';
import '../../data/repositories/character_repository.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(EpisodeAdapter());
  Hive.registerAdapter(ApiInfoAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(CharactersResponseAdapter());
  Hive.registerAdapter(LocationInfoAdapter());
}

void initializeGetIt(
  Box<CharacterDTO> charactersBox,
  Box<EpisodeDTO> episodesBox,
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

  final charactersBox = await Hive.openBox<CharacterDTO>(charactersBoxName);
  final episodesBox = await Hive.openBox<EpisodeDTO>(episodesBoxName);

  initializeGetIt(charactersBox, episodesBox, prefs);

}

