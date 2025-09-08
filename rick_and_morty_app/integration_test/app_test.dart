import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_and_morty_app/main.dart' as app;
import 'package:rick_and_morty_app/presentation/pages/character_list_page/character_list_item_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full user flow: filter, details, navigate, and change theme',
          (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        print('Checking for character presence...');
        expect(find.text('Rick Sanchez'), findsWidgets);

        print('Filtering characters by status "Dead"...');
        await tester.tap(find.text('Status'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Dead').last);
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Search'));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        print('Checking filter results...');
        expect(find.text('Rick Sanchez'), findsNothing);
        expect(find.text('Adjudicator Rick'), findsWidgets);

        print('Opening details for character "Adjudicator Rick"...');
        await tester.tap(find.widgetWithText(CharacterListItemWidget, 'Adjudicator Rick'));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        print('Verifying that the details screen is open...');
        expect(find.text('Last known location:'), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'Adjudicator Rick'), findsOneWidget);

        print('Returning to the main screen...');
        await tester.pageBack();
        await tester.pumpAndSettle();

        print('Navigating to settings...');
        await tester.tap(find.byIcon(Icons.settings));
        await tester.pumpAndSettle();

        print('On the settings screen.');
        expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);

        final BuildContext context = tester.element(find.byType(Scaffold).first);
        final initialBrightness = Theme.of(context).brightness;
        print('Initial theme: ${initialBrightness.name}');

        final targetThemeName = initialBrightness == Brightness.light ? 'Dark' : 'Light';
        print('Switching theme to $targetThemeName...');
        await tester.tap(find.text(targetThemeName));
        await tester.pumpAndSettle();

        final newBrightness = Theme.of(tester.element(find.byType(Scaffold).first)).brightness;
        print('New theme: ${newBrightness.name}');

        expect(newBrightness, isNot(initialBrightness));
        print('Theme changed successfully.');
      });
}
