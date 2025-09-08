import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/theme/theme_state.dart';
import 'package:rick_and_morty_app/presentation/pages/settings_page.dart';
import 'package:rick_and_morty_app/presentation/widgets/theme_selection_card_widget.dart';

class MockThemeCubit extends MockCubit<ThemeState> implements ThemeCubit {}

void main() {
  late MockThemeCubit mockThemeCubit;

  setUp(() {
    mockThemeCubit = MockThemeCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ThemeCubit>.value(
          value: mockThemeCubit,
          child: const ThemeSelectionCardWidget(),
        ),
      ),
    );
  }

  group('ThemeSelectionCardWidget', () {
    testWidgets('renders title and radio buttons correctly', (tester) async {
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(Brightness.light));
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Choose a theme'), findsOneWidget);
      expect(find.byType(RadioListTile<Brightness>), findsNWidgets(2));
    });

    testWidgets('selects "Light" theme when state is light', (tester) async {
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(Brightness.light));
      await tester.pumpWidget(createWidgetUnderTest());
      final lightRadioTile = tester.widget<RadioListTile<Brightness>>(
        find.widgetWithText(RadioListTile<Brightness>, 'Light'),
      );
      expect(lightRadioTile.groupValue, Brightness.light);
      expect(lightRadioTile.value, Brightness.light);
    });

    testWidgets('selects "Dark" theme when state is dark', (tester) async {
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(Brightness.dark));
      await tester.pumpWidget(createWidgetUnderTest());
      final darkRadioTile = tester.widget<RadioListTile<Brightness>>(
        find.widgetWithText(RadioListTile<Brightness>, 'Dark'),
      );
      expect(darkRadioTile.groupValue, Brightness.dark);
      expect(darkRadioTile.value, Brightness.dark);
    });

    testWidgets('calls setThemeBrightness with dark when "Dark" is tapped',
        (tester) async {
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(Brightness.light));
      when(() => mockThemeCubit.setThemeBrightness(Brightness.dark))
          .thenAnswer((_) async {});
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('Dark'));
      verify(() => mockThemeCubit.setThemeBrightness(Brightness.dark))
          .called(1);
    });

    testWidgets('SettingsPage renders correctly', (tester) async {
      final mockThemeCubit = MockThemeCubit();
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(Brightness.light));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ThemeCubit>.value(
            value: mockThemeCubit,
            child: const SettingsPage(),
          ),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
      expect(find.byType(ThemeSelectionCardWidget), findsOneWidget);
    });
  });
}
