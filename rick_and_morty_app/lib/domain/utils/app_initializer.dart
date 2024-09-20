import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty_app/data/api_client/api_client.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_theme_repository.dart';
import 'package:rick_and_morty_app/data/data_sources/characters_list_data_source.dart';
import 'package:rick_and_morty_app/data/data_sources/episode_data_source.dart';
import 'package:rick_and_morty_app/data/data_sources/theme_repository.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_app/data/repositories/characters_list_repository_impl.dart';
import 'package:rick_and_morty_app/data/repositories/episode_repository_impl.dart';
import 'package:rick_and_morty_app/domain/repositories/characters_list_repository.dart';
import 'package:rick_and_morty_app/domain/repositories/episode_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/data/dto/character.dart';
import 'package:rick_and_morty_app/data/dto/episode.dart';
import '../../data/dto/api_info.dart';
import '../../data/dto/characters_response.dart';
import '../../data/data_sources/character_data_source.dart';
import '../repositories/character_repository.dart';

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
  GetIt.I.registerLazySingleton<CharactersListRepository>(
    () => CharactersListRepositoryImpl(
      abstractCharactersListDataSource: CharactersListDataSource(
          ApiClient(
              charactersBox,
              episodesBox
          ),
      ),
    ),
  );

  GetIt.I.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      abstractCharacterDataSource: CharacterDataSource(
        ApiClient(
            charactersBox,
            episodesBox
        ),
      ),
    ),
  );

  GetIt.I.registerLazySingleton<EpisodeRepository>(
    () => EpisodeRepositoryImpl(
      abstractEpisodeDataSource: EpisodeDataSource(
          ApiClient(
              charactersBox,
              episodesBox
          )
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

