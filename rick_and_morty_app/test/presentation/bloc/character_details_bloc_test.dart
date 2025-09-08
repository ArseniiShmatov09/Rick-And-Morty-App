import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';
import 'package:rick_and_morty_app/domain/models/episode_model.dart';
import 'package:rick_and_morty_app/domain/usecases/get_character.dart';
import 'package:rick_and_morty_app/domain/usecases/get_episode.dart';
import 'package:rick_and_morty_app/presentation/bloc/character_details/character_details_bloc.dart';

class MockGetCharacter extends Mock implements GetCharacter {}
class MockGetEpisode extends Mock implements GetEpisode {}

void main() {
  group('CharacterDetailsBloc', () {
    late MockGetCharacter mockGetCharacter;
    late MockGetEpisode mockGetEpisode;

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
      image: 'image.png',
      episode: ['https://rickandmortyapi.com/api/episode/1'],
      created: '2023-01-01',
    );
    final mockEpisode =  EpisodeModel(
      id: 1,
      name: 'Pilot',
      airDate: '2013-12-02',
      episode: 'S01E01',
      characters: ['Rick', 'Morty'],
      url: 'url',
      created: DateTime(2013, 12, 2),
    );
    final testException = Exception('Failed to load');

    setUp(() {
      mockGetCharacter = MockGetCharacter();
      mockGetEpisode = MockGetEpisode();
    });

    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'emits [Loading, Loaded] when LoadCharacterDetails is added and succeeds',
      setUp: () {
        when(() => mockGetCharacter(any())).thenAnswer((_) async => mockCharacter);
        when(() => mockGetEpisode(1)).thenAnswer((_) async => mockEpisode);
      },
      build: () => CharacterDetailsBloc(getCharacter: mockGetCharacter, getEpisode: mockGetEpisode),
      act: (bloc) => bloc.add(const LoadCharacterDetails(characterId: 1)),
      expect: () => [
        const CharacterDetailsLoading(),
        CharacterDetailsLoaded(mockCharacter, mockEpisode),
      ],
    );


    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'emits [Loading, Failure] when GetCharacter use case fails',
      setUp: () {
        when(() => mockGetCharacter(any())).thenThrow(testException);
      },
      build: () => CharacterDetailsBloc(getCharacter: mockGetCharacter, getEpisode: mockGetEpisode),
      act: (bloc) => bloc.add(const LoadCharacterDetails(characterId: 1)),
      expect: () => [
        const CharacterDetailsLoading(),
        CharacterDetailsLoadingFailure(testException),
      ],
      verify: (_) {
        verify(() => mockGetCharacter(1)).called(1);
        verifyNever(() => mockGetEpisode(any()));
      },
    );

    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'emits [Loading, Failure] when GetEpisode use case fails',
      setUp: () {
        when(() => mockGetCharacter(any())).thenAnswer((_) async => mockCharacter);
        when(() => mockGetEpisode(any())).thenThrow(testException);
      },
      build: () => CharacterDetailsBloc(getCharacter: mockGetCharacter, getEpisode: mockGetEpisode),
      act: (bloc) => bloc.add(const LoadCharacterDetails(characterId: 1)),
      expect: () => [
        const CharacterDetailsLoading(),
        CharacterDetailsLoadingFailure(testException),
      ],
      verify: (_) {
        verify(() => mockGetCharacter(1)).called(1);
        verify(() => mockGetEpisode(1)).called(1);
      },
    );
  });
}