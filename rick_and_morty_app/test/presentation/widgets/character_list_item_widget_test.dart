import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/pages/character_list_page/character_list_item_widget.dart';

class MockNetworkConnection extends Mock implements NetworkConnection {}

void main() {
  final mockCharacter = CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: LocationInfoModel(name: 'Earth'),
    location: LocationInfoModel(name: 'Earth'),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: [],
    created: '',
    url: '',
  );

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('CharacterListItemWidget', () {
    late MockNetworkConnection mockNetworkConnection;

    setUp(() {
      mockNetworkConnection = MockNetworkConnection();
    });

    testWidgets('renders character name, status, and species', (tester) async {
      when(() => mockNetworkConnection.isOffline).thenReturn(false);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest(
          CharacterListItemWidget(
            character: mockCharacter,
            networkConnection: mockNetworkConnection,
            onTap: () {},
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.text('Rick Sanchez'), findsOneWidget);
        expect(find.text('Alive - Human'), findsOneWidget);
      });
    });

    testWidgets('shows network image when online', (tester) async {
      when(() => mockNetworkConnection.isOffline).thenReturn(false);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest(
          CharacterListItemWidget(
            character: mockCharacter,
            networkConnection: mockNetworkConnection,
            onTap: () {},
          ),
        ));
        await tester.pumpAndSettle();

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.image, isA<NetworkImage>());
      });
    });

    testWidgets('shows asset image when offline', (tester) async {
      when(() => mockNetworkConnection.isOffline).thenReturn(true);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest(
          CharacterListItemWidget(
            character: mockCharacter,
            networkConnection: mockNetworkConnection,
            onTap: () {},
          ),
        ));
        await tester.pumpAndSettle();

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.image, isA<AssetImage>());
        expect((image.image as AssetImage).assetName, 'assets/images/no_image.jpeg');
      });
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool wasTapped = false;
      when(() => mockNetworkConnection.isOffline).thenReturn(false);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest(
          CharacterListItemWidget(
            character: mockCharacter,
            networkConnection: mockNetworkConnection,
            onTap: () {
              wasTapped = true;
            },
          ),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        expect(wasTapped, isTrue);
      });
    });
  });
}
