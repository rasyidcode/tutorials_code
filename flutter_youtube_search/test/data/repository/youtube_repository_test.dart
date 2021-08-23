import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/network/youtube_data_source.dart';
import 'package:github_user_searcch/data/repository/youtube_search_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'youtube_repository_test.mocks.dart';

@GenerateMocks([YoutubeDataSource])
void main() {
  String fixture(String name) =>
      File('test/data/fixtures/$name.json').readAsStringSync();

  late MockYoutubeDataSource mockDataSource;
  late YoutubeSearchRepository repository;

  setUp(() {
    mockDataSource = MockYoutubeDataSource();
    repository = YoutubeSearchRepository(mockDataSource);
  });

  group('Search', () {
    YoutubeSearchResult? searchResult;
    YoutubeSearchResult? noNextPageSearchResult;
    YoutubeSearchResult? emptySearchResult;

    setUp(() {
      searchResult = YoutubeSearchResult.fromJson(fixture('search_result'));
      noNextPageSearchResult =
          YoutubeSearchResult.fromJson(fixture('search_result_no_next'));
      emptySearchResult =
          YoutubeSearchResult.fromJson(fixture('search_result_empty'));
    });

    group('Search', () {
      group('searchVideos', () {
        test('returns a List<SearchItem>', () async {
          // stubing searchVideos
          when(mockDataSource.searchVideos(
                  query: anyNamed('query'), pageToken: anyNamed('pageToken')))
              .thenAnswer((_) async => searchResult);

          // Interact
          final searchResultList =
              await repository.searchVideos('flutter tutorial');

          expect(searchResultList, searchResult?.items);

          verify(mockDataSource.searchVideos(
              query: argThat(equals('flutter tutorial'), named: 'query'),
              pageToken: argThat(equals(''), named: 'pageToken')));
        });

        test('throws a NullSearchResultException it returns null', () {
          // stubbing searchVideos
          when(mockDataSource.searchVideos(
                  query: anyNamed('query'), pageToken: anyNamed('pageToken')))
              .thenAnswer((_) async => null);
          // catch an exception
          expect(() async => await repository.searchVideos('asdlkfjsdkfjdf'),
              throwsA(TypeMatcher<NullSearchResultException>()));
        });

        test(
            'throws a NoSearchResultException when calling with an unknown query string',
            () {
          // stubbing searchVideos
          when(mockDataSource.searchVideos(
                  query: anyNamed('query'), pageToken: anyNamed('pageToken')))
              .thenAnswer((_) async => emptySearchResult);
          // catch an exception
          expect(() async => await repository.searchVideos('asdlkfjsdkfjdf'),
              throwsA(TypeMatcher<NoSearchResultsException>()));
        });
      });

      group('fetchNextResultPage', () {
        test(
            'throws a SearchNotInitException when called WITHOUT previously calling searchVideos',
            () {
          expect(() => repository.fetchNextVideos(),
              throwsA(TypeMatcher<SearchNotInitException>()));

          verifyNever(mockDataSource.searchVideos(
              query: anyNamed('query'), pageToken: anyNamed('pageToken')));
        });

        test(
            'returns a List<SearchItem> containing the results from the next page when called AFTER calling searchVideos',
            () async {
          // stubing searchVideos
          when(mockDataSource.searchVideos(
                  query: anyNamed('query'), pageToken: anyNamed('pageToken')))
              .thenAnswer((_) async => searchResult);

          await repository.searchVideos('flutter tutorial');
          final nextPageList = await repository.fetchNextVideos();

          expect(nextPageList, searchResult?.items);

          verifyInOrder([
            mockDataSource.searchVideos(
              query: argThat(
                equals('flutter tutorial'),
                named: 'query',
              ),
              pageToken: argThat(
                equals(''),
                named: 'pageToken',
              ),
            ),
            mockDataSource.searchVideos(
              query: argThat(
                equals('flutter tutorial'),
                named: 'query',
              ),
              pageToken: argThat(
                equals(searchResult?.nextPageToken),
                named: 'pageToken',
              ),
            ),
          ]);
        });

        test(
            'throws a NoNextPageTokenException when called if we are at the end of the result list (hence no next page)',
            () async {
          // stubing searchVideos
          when(mockDataSource.searchVideos(
                  query: anyNamed('query'), pageToken: anyNamed('pageToken')))
              .thenAnswer((_) async => noNextPageSearchResult);

          await repository.searchVideos('flutter tutorial');

          expect(
            () => repository.fetchNextVideos(),
            throwsA(TypeMatcher<NoNextPageTokenException>()),
          );

          verifyNever(
            mockDataSource.searchVideos(
              query: anyNamed('query'),
              pageToken: argThat(
                isNot(equals('')),
                named: 'pageToken',
              ),
            ),
          );
        });
      });
    });
  });
}
