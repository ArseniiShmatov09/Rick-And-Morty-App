import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/data/data_sources/interfaces/abstract_theme_repository.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';

class MockThemeRepository extends Mock implements AbstractThemeRepository {}

void main() {
  group('ThemeCubit', () {
    late MockThemeRepository mockThemeRepository;

    setUp(() {
      mockThemeRepository = MockThemeRepository();
    });

    test('initial state is light when repository returns false', () {
      when(() => mockThemeRepository.isDarkThemeSelected()).thenReturn(false);
      expect(ThemeCubit(themeRepository: mockThemeRepository).state, const ThemeState(Brightness.light));
    });

    test('initial state is dark when repository returns true', () {
      when(() => mockThemeRepository.isDarkThemeSelected()).thenReturn(true);
      expect(ThemeCubit(themeRepository: mockThemeRepository).state, const ThemeState(Brightness.dark));
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits [ThemeState(Brightness.dark)] and saves selection when setThemeBrightness is called with dark',
      setUp: () {
        when(() => mockThemeRepository.isDarkThemeSelected()).thenReturn(false);
        when(() => mockThemeRepository.setDarkThemeSelected(any())).thenAnswer((_) async {});
      },
      build: () => ThemeCubit(themeRepository: mockThemeRepository),
      act: (cubit) => cubit.setThemeBrightness(Brightness.dark),
      expect: () => [const ThemeState(Brightness.dark)],
      verify: (_) {
        verify(() => mockThemeRepository.setDarkThemeSelected(true)).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits [ThemeState(Brightness.light)] and saves selection when setThemeBrightness is called with light',
      setUp: () {
        when(() => mockThemeRepository.isDarkThemeSelected()).thenReturn(true);
        when(() => mockThemeRepository.setDarkThemeSelected(any())).thenAnswer((_) async {});
      },
      build: () => ThemeCubit(themeRepository: mockThemeRepository),
      act: (cubit) => cubit.setThemeBrightness(Brightness.light),
      expect: () => [const ThemeState(Brightness.light)],
      verify: (_) {
        verify(() => mockThemeRepository.setDarkThemeSelected(false)).called(1);
      },
    );
  });
}