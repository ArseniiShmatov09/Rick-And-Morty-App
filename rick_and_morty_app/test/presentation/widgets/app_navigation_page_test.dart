import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/presentation/pages/app_navigation_page.dart';
import 'package:rick_and_morty_app/presentation/pages/character_list_page/characters_list_widget.dart';
import 'package:rick_and_morty_app/presentation/pages/settings_page.dart';

class MockCharacterListBloc extends MockBloc<CharacterListEvent, CharacterListState>
    implements CharacterListBloc {}
class MockThemeCubit extends MockCubit<ThemeState> implements ThemeCubit {}

void main() {
  late MockCharacterListBloc mockCharacterListBloc;
  late MockThemeCubit mockThemeCubit;

  setUp(() {
    mockCharacterListBloc = MockCharacterListBloc();
    mockThemeCubit = MockThemeCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CharacterListBloc>.value(value: mockCharacterListBloc),
          BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
        ],
        child: AppNavigationPage(),
      ),
    );
  }

  group('AppNavigationPage', () {
    testWidgets('displays CharactersListPage initially', (tester) async {
      when(() => mockCharacterListBloc.state).thenReturn(const CharacterListLoaded([], false));
      when(() => mockThemeCubit.state).thenReturn(const ThemeState(Brightness.light));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CharactersListPage), findsOneWidget);
      expect(find.byType(SettingsPage), findsNothing);
    });

    testWidgets('navigates to SettingsPage when settings icon is tapped', (tester) async {
      when(() => mockCharacterListBloc.state).thenReturn(const CharacterListLoaded([], false));
      when(() => mockThemeCubit.state).thenReturn(const ThemeState(Brightness.light));
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(CharactersListPage), findsNothing);
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('navigates back to CharactersListPage', (tester) async {
      when(() => mockCharacterListBloc.state).thenReturn(const CharacterListLoaded([], false));
      when(() => mockThemeCubit.state).thenReturn(const ThemeState(Brightness.light));
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      expect(find.byType(CharactersListPage), findsOneWidget);
      expect(find.byType(SettingsPage), findsNothing);
    });
  });
}