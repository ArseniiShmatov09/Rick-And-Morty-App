import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/pages/character_details_page/header_details_info_widget.dart';

class MockNetworkConnection extends Mock implements NetworkConnection {}

void main() {
  final mockCharacter = CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: 'Scientist',
    gender: 'Male',
    origin: LocationInfoModel(name: 'Earth'),
    location: LocationInfoModel(name: 'Earth'),
    url: 'url',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/1'],
    created: '2025-01-01',
  );

  group('HeaderDetailsInfoWidget', () {
    late MockNetworkConnection mockNetworkConnection;

    setUp(() {
      mockNetworkConnection = MockNetworkConnection();
    });

    testWidgets('displays name, status, and species', (tester) async {
      when(() => mockNetworkConnection.isOffline).thenReturn(false);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HeaderDetailsInfoWidget(
                character: mockCharacter,
                networkConnection: mockNetworkConnection,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Rick Sanchez'), findsOneWidget);
        expect(find.text('Alive - Human'), findsOneWidget);
      });
    });

    testWidgets('displays asset image when offline', (tester) async {
      when(() => mockNetworkConnection.isOffline).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderDetailsInfoWidget(
              character: mockCharacter,
              networkConnection: mockNetworkConnection,
            ),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, 'assets/images/no_image.jpeg');
    });
  });
}
