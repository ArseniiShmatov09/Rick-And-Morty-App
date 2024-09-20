import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/abstract_theme_repository.dart';

class ThemeRepository implements AbstractThemeRepository{

  static const _isDarkThemeSelected = 'dark_theme_selected';
  final SharedPreferences preferences;

  ThemeRepository({required this.preferences});

  @override
  bool isDarkThemeSelected(){
    final selected = preferences.getBool(_isDarkThemeSelected);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async{
    await preferences.setBool(_isDarkThemeSelected, selected);
  }
}