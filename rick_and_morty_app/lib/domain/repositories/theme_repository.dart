import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository{

  static const _isDarkThemeSelected = 'dark_theme_selected';
  final SharedPreferences preferences;

  ThemeRepository({required this.preferences});

  bool isDarkThemeSelected(){
    final selected = preferences.getBool(_isDarkThemeSelected);
    return selected ?? false;
  }

  Future<void> setDarkThemeSelected(bool selected) async{
    await preferences.setBool(_isDarkThemeSelected, selected);
  }
}