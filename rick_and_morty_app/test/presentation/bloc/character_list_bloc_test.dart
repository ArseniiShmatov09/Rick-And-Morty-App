import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/character_response_model.dart';
import 'package:rick_and_morty_app/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty_app/domain/usecases/get_filtered_characters.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_list/character_list_bloc.dart';

class MockGetAllCharacters extends Mock implements GetAllCharacters {}

class MockGetFilteredCharacters extends Mock implements GetFilteredCharacters {}

void main() {
  group('CharacterListBloc', () {
    late MockGetAllCharacters mockGetAllCharacters;
    late MockGetFilteredCharacters mockGetFilteredCharacters;

    final mockCharactersPage1 = [
      CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        type: 'Scientist',
        gender: 'Male',
        origin: LocationInfoModel(name: 'Earth'),
        location: LocationInfoModel(name: 'Earth'),
        url: 'url',
        image: 'image.png',
        episode: [
          'https://rickandmortyapi.com/api/episode/1',
          'https://rickandmortyapi.com/api/episode/2'
        ],
        created: '2023-01-01',
      )
    ];
    final mockCharactersPage2 = [
      CharacterModel(
        id: 2,
        name: 'Morty',
        status: 'Alive',
        species: 'Human',
        type: 'Scientist',
        gender: 'Male',
        origin: LocationInfoModel(name: 'Earth'),
        location: LocationInfoModel(name: 'Earth'),
        url: 'url',
        image: 'image.png',
        episode: [
          'https://rickandmortyapi.com/api/episode/1',
          'https://rickandmortyapi.com/api/episode/2'
        ],
        created: '2023-01-01',
      )
    ];

    final mockResponsePage1 = CharactersResponseModel(
      info: ApiInfoModel(pages: 3, count: 3),
      characters: mockCharactersPage1,
    );
    final mockResponsePage2 = CharactersResponseModel(
      info: ApiInfoModel(pages: 3, count: 3),
      characters: mockCharactersPage2,
    );
    final testException = Exception('Failed to load');

    setUp(() {
      mockGetAllCharacters = MockGetAllCharacters();
      mockGetFilteredCharacters = MockGetFilteredCharacters();
    });

    blocTest<CharacterListBloc, CharacterListState>(
      'emits [Loading, Loaded] on initial LoadCharacterList success',
      setUp: () {
        when(() => mockGetAllCharacters(any()))
            .thenAnswer((_) async => mockResponsePage1);
      },
      build: () =>
          CharacterListBloc(
            getAllCharacters: mockGetAllCharacters,
            getFilteredCharacters: mockGetFilteredCharacters,
          ),
      act: (bloc) => bloc.add(const LoadCharacterList(page: 1)),
      expect: () =>
      [
        const CharacterListLoading(),
        CharacterListLoaded(mockCharactersPage1, true),
      ],
    );

    blocTest<CharacterListBloc, CharacterListState>(
      'emits [Loading, Loaded] on LoadFilteredCharacterList success',
      setUp: () {
        when(() => mockGetFilteredCharacters(any(), any(), any()))
            .thenAnswer((_) async => mockResponsePage1);
      },
      build: () =>
          CharacterListBloc(
            getAllCharacters: mockGetAllCharacters,
            getFilteredCharacters: mockGetFilteredCharacters,
          ),
      act: (bloc) =>
          bloc.add(const LoadFilteredCharacterList(
              page: 1, status: 'Alive', species: 'Human')),
      expect: () =>
      [
        const CharacterListLoading(),
        CharacterListLoaded(mockCharactersPage1, true),
      ],
      verify: (_) {
        verify(() => mockGetFilteredCharacters('Alive', 'Human', 1)).called(1);
      },
    );

    blocTest<CharacterListBloc, CharacterListState>(
      'emits [Loaded] with combined list on LoadNextPage success',
      setUp: () {
        when(() => mockGetAllCharacters(2))
            .thenAnswer((_) async => mockResponsePage2);
      },
      build: () =>
          CharacterListBloc(
            getAllCharacters: mockGetAllCharacters,
            getFilteredCharacters: mockGetFilteredCharacters,
          ),
      seed: () => CharacterListLoaded(mockCharactersPage1, true),
      act: (bloc) {
        bloc.currentPage = 2;
        bloc.characters.addAll(mockCharactersPage1);
        bloc.add(const LoadNextPage());
      },
      expect: () =>
      [
        CharacterListLoaded(mockCharactersPage1 + mockCharactersPage2, true),
      ],
    );

    blocTest<CharacterListBloc, CharacterListState>(
      'emits [Loading, Failure] on LoadCharacterList failure',
      setUp: () {
        when(() => mockGetAllCharacters(any())).thenThrow(testException);
      },
      build: () =>
          CharacterListBloc(
            getAllCharacters: mockGetAllCharacters,
            getFilteredCharacters: mockGetFilteredCharacters,
          ),
      act: (bloc) => bloc.add(const LoadCharacterList(page: 1)),
      expect: () =>
      [
        const CharacterListLoading(),
        CharacterListLoadingFailure(testException),
      ],
    );
  });
}
