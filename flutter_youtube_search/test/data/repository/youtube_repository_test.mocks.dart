// Mocks generated by Mockito 5.0.10 from annotations
// in github_user_searcch/test/data/repository/youtube_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:github_user_searcch/data/models/search/youtube_search_result.dart'
    as _i5;
import 'package:github_user_searcch/data/network/youtube_data_source.dart'
    as _i3;
import 'package:http/src/client.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeClient extends _i1.Fake implements _i2.Client {}

/// A class which mocks [YoutubeDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockYoutubeDataSource extends _i1.Mock implements _i3.YoutubeDataSource {
  MockYoutubeDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient()) as _i2.Client);
  @override
  _i4.Future<_i5.YoutubeSearchResult?> searchVideos(
          {String? query, String? pageToken = r''}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #searchVideos, [], {#query: query, #pageToken: pageToken}),
              returnValue: Future<_i5.YoutubeSearchResult?>.value())
          as _i4.Future<_i5.YoutubeSearchResult?>);
}