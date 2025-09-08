import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/pages/internet_check_page.dart';
import 'package:rick_and_morty_app/presentation/widgets/loading_indicator_widget.dart';

class MockNetworkConnection extends Mock implements NetworkConnection {}

void main() {

  testWidgets('InternetCheckPage shows message and buttons', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: InternetCheckPage()));

    expect(find.text('Please check your internet connection and try again'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('Continue offline'), findsOneWidget);
  });

  testWidgets('InternetCheckPage shows loading indicator on Try again', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: InternetCheckPage()));

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(find.byType(LoadingIndicatorWidget), findsOneWidget);
  });
}
