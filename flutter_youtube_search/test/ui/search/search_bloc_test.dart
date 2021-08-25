import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/models/search/youtube_search_error.dart';
import 'package:github_user_searcch/data/repository/youtube_search_repository.dart';
import 'package:github_user_searcch/ui/search/search.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([YoutubeSearchRepository])
void main() {
  late SearchBloc searchBloc;
  late MockYoutubeSearchRepository mockRepository;

  String fixture(String name) =>
      File('test/data/fixtures/$name.json').readAsStringSync();

  setUp(() {
    mockRepository = MockYoutubeSearchRepository();
    searchBloc = SearchBloc(mockRepository);
  });

  test('initial state is correct', () {
    expect(searchBloc.state, SearchState.initial());
  });

  group('SearchInitiated', () {
    late BuiltList<SearchItem> searchResultList;

    setUp(() {
      searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result'))!.items;

      when(mockRepository.searchVideos(any))
          .thenAnswer((_) async => searchResultList);
    });

    test('emits ["nothing"] (only initial state) for an empty search string',
        () {
      final expectedResponse = [
        SearchState.initial(),
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('');

      verifyNever(mockRepository.searchVideos(any));
    });

    test('emits [loading, success] for a valid search string', () async {
      final expectedResponse = [
        // SearchState.initial(),
        SearchState.loading(),
        SearchState.success(searchResultList)
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('flutter tutorial');

      await untilCalled(mockRepository.searchVideos(any));

      verify(mockRepository.searchVideos(argThat(equals('flutter tutorial'))));
    });

    test(
        'emits [loading, success, initial] for a search string which is first valid and then empty',
        () async {
      final expectedResponse = [
        SearchState.loading(),
        SearchState.success(searchResultList),
        SearchState.initial()
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('flutter tutorial');
      searchBloc.onSearchInitiated('');

      await untilCalled(mockRepository.searchVideos(any));

      verify(mockRepository.searchVideos(argThat(equals('flutter tutorial'))))
          .called(1);
    });

    test('emits [loading, failure] when repository throws a YoutubeSearchError',
        () async {
      reset(mockRepository);
      when(mockRepository.searchVideos(any))
          .thenThrow(YoutubeSearchError('Something went wrong'));

      final expectedResponse = [
        SearchState.loading(),
        SearchState.failure('Something went wrong')
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('flutter tutorial');

      await untilCalled(mockRepository.searchVideos(any));

      verify(mockRepository.searchVideos(argThat(equals('flutter tutorial'))))
          .called(1);
    });

    test(
        'emits [loading, failure] when repository throws a NoSearchResultsException',
        () async {
      reset(mockRepository);
      when(mockRepository.searchVideos(any))
          .thenThrow(NoSearchResultsException());

      final expectedResponse = [
        SearchState.loading(),
        SearchState.failure(NoSearchResultsException().message)
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('flutter tutorial');

      await untilCalled(mockRepository.searchVideos(any));

      verify(mockRepository.searchVideos(argThat(equals('flutter tutorial'))))
          .called(1);
    });
  });

  group('FetchNextResultPage', () {
    late BuiltList<SearchItem> searchResultList;

    setUp(() {
      searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result'))!.items;
    });

    test('emits [success] if fetchNextPageResultPage', () async {
      when(mockRepository.fetchNextVideos())
          .thenAnswer((_) async => searchResultList);

      final expectedResponse = [SearchState.success(searchResultList)];

      expectLater(searchBloc.stream, emitsInOrder(expectedResponse));

      searchBloc.fetchNextResultPage();

      await untilCalled(mockRepository.fetchNextVideos());
      verify(mockRepository.fetchNextVideos()).called(1);
    });

    test(
        'emits currentState with hasReachedEndOfResults == true when no more results are present',
        () async {
      when(mockRepository.fetchNextVideos())
          .thenThrow(NoNextPageTokenException());

      final expectedResponse = [
        SearchState.initial().rebuild((b) => b..hasReachedEndOfResults = true)
      ];

      expectLater(
        searchBloc.stream,
        emitsInOrder(expectedResponse),
      );

      searchBloc.fetchNextResultPage();

      await untilCalled(mockRepository.fetchNextVideos());
      verify(mockRepository.fetchNextVideos()).called(1);
    });

    test(
        'emits [failure] when fetchNextResultPage is called before the search has begun',
        () async {
      when(mockRepository.fetchNextVideos())
          .thenThrow(SearchNotInitException());

      expectLater(
        searchBloc.stream,
        emitsInOrder(
          [
            SearchState.failure(SearchNotInitException().message),
          ],
        ),
      );

      searchBloc.fetchNextResultPage();

      await untilCalled(mockRepository.fetchNextVideos());
      verify(mockRepository.fetchNextVideos()).called(1);
    });

    test('emits [failure] when repository throws a YoutubeSearchError',
        () async {
      when(mockRepository.fetchNextVideos())
          .thenThrow(YoutubeSearchError('Something went wrong'));

      expectLater(
        searchBloc.stream,
        emitsInOrder(
          [
            SearchState.failure('Something went wrong'),
          ],
        ),
      );

      searchBloc.fetchNextResultPage();

      await untilCalled(mockRepository.fetchNextVideos());
      verify(mockRepository.fetchNextVideos()).called(1);
    });
  });
}
