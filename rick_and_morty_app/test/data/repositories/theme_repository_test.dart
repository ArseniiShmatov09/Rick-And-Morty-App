import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/data/repositories/theme_repository.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPreferences;
  late ThemeRepository repository;

  setUp(() {
    mockPreferences = MockSharedPreferences();
    repository = ThemeRepository(preferences: mockPreferences);
  });

  const themeKey = 'dark_theme_selected';

  group('isDarkThemeSelected', () {
    test('should return true when preferences contains true', () {
      when(() => mockPreferences.getBool(any())).thenReturn(true);

      final result = repository.isDarkThemeSelected();

      expect(result, isTrue);
      verify(() => mockPreferences.getBool(themeKey)).called(1);
    });

    test('should return false when preferences is null', () {
      when(() => mockPreferences.getBool(any())).thenReturn(null);

      final result = repository.isDarkThemeSelected();

      expect(result, isFalse);
    });
  });

  group('setDarkThemeSelected', () {
    test('should call setBool on preferences with correct value', () async {

      when(() => mockPreferences.setBool(any(), any())).thenAnswer((_) async => true);

      await repository.setDarkThemeSelected(true);

      verify(() => mockPreferences.setBool(themeKey, true)).called(1);
    });
  });
}