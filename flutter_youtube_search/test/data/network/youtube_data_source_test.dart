import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_searcch/api_key.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/models/search/youtube_search_error.dart';
import 'package:github_user_searcch/data/network/youtube_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'youtube_data_source_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MySimpleMock)])
void main() {
  String fixture(String name) =>
      File('test/data/fixtures/$name.json').readAsStringSync();

  late MySimpleMock mockClient;
  late YoutubeDataSource dataSource;

  setUp(() {
    mockClient = MySimpleMock();
    dataSource = YoutubeDataSource(mockClient);
  });

  group('searchVideos', () {
    test('returns YoutubeSearchResult when the call completes successfully',
        () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          fixture('search_result'),
          200,
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        ),
      );

      YoutubeSearchResult? result =
          await dataSource.searchVideos(query: 'test again');
      expect(result, TypeMatcher<YoutubeSearchResult>());
      expect(result!.items.length, 2);
      expect(
        result.items[0].snippet.title,
        startsWith('Tutorial Flutter #1'),
      );
    });

    test('throws an error on bad request', () async {
      when(
        mockClient.get(any),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('error'),
          400,
        ),
      );

      expect(
        () => dataSource.searchVideos(query: 'test', pageToken: 'abcd'),
        throwsA(
          TypeMatcher<YoutubeSearchError>(),
        ),
      );
    });

    test('makes an HTTP request to a proper URL', () {
      when(
        mockClient.get(any),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('search_result'),
          200,
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        ),
      );

      dataSource.searchVideos(query: 'test');
      // dataSource.searchVideos(query: 'flutter tutorial');
      // dataSource.searchVideos(query: 'amazing flutter', pageToken: 'abcd');

      verify(mockClient.get(argThat(contains('test'))));
      // verifyInOrder([
      //   mockClient.get(argThat(contains('test')), headers: anyNamed('headers')),
      //   mockClient.get(any, headers: anyNamed('headers')),
      //   mockClient.get(any, headers: anyNamed('headers')),
      // ]);
    });
  });
}
