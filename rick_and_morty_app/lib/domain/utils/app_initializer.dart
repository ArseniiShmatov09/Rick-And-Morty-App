import 'package:hive_flutter/adapters.dart';
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

Future<Map<String, dynamic>> initializeApp() async {
  await initializeHive();
  final prefs = await SharedPreferences.getInstance();

  const String charactersBoxName = 'characters_box';
  const String episodesBoxName = 'episodes_box';

  final charactersBox = await Hive.openBox<Character>(charactersBoxName);
  final episodesBox = await Hive.openBox<Episode>(episodesBoxName);

  return {
    'preferences': prefs,
    'charactersBox': charactersBox,
    'episodesBox': episodesBox,
  };
}
