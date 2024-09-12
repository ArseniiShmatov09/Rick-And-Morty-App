import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rick_and_morty_app/domain/repositories/theme_repository.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  ThemeCubit({
    required ThemeRepository themeRepository,
  }) : _themeRepository = themeRepository,
        super (const ThemeState(Brightness.light)){
    _checkSelectedTheme();
  }

  final ThemeRepository _themeRepository;

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
