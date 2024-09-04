import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rick_and_morty_app/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/domain/repositories/settings/settings_repository.dart';

class ThemeCubit extends Cubit<ThemeState>{
  ThemeCubit({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository,
        super (const ThemeState(Brightness.light)){
    _checkSelectedTheme();
  }

  final SettingsRepository _settingsRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    emit(ThemeState(brightness));
    _settingsRepository.setDarkThemeSelected(brightness == Brightness.dark);
  }

  void _checkSelectedTheme(){
    final brightness = _settingsRepository.isDarkThemeSelected()
        ? Brightness.dark
        : Brightness.light;
    emit(ThemeState(brightness));
  }
}
