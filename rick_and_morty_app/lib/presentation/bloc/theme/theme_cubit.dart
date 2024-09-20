import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';

import '../../../data/data_sources/interfaces/abstract_theme_repository.dart';

class ThemeCubit extends Cubit<ThemeState>{
  ThemeCubit({
    required AbstractThemeRepository themeRepository,
  }) : _themeRepository = themeRepository,
        super (const ThemeState(Brightness.light)){
    _checkSelectedTheme();
  }

  final AbstractThemeRepository _themeRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    emit(ThemeState(brightness));
    _themeRepository.setDarkThemeSelected(brightness == Brightness.dark);
  }

  void _checkSelectedTheme(){
    final brightness = _themeRepository.isDarkThemeSelected()
        ? Brightness.dark
        : Brightness.light;
    emit(ThemeState(brightness));
  }
}
