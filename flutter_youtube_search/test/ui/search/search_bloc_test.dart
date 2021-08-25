import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
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
        searchBloc.state,
        emitsInOrder(expectedResponse),
      );

      searchBloc.onSearchInitiated('');

      verifyNever(mockRepository.searchVideos(any));
    });

    // test('emits [loading, success] for a valid search string', () async {
    //   final expectedResponse = [
    //     SearchState.initial(),
    //     SearchState.loading(),
    //     SearchState.success(searchResultList)
    //   ];

    //   expectLater(
    //     searchBloc.state,
    //     emitsInOrder(expectedResponse),
    //   );

    //   searchBloc.onSearchInitiated('flutter tutorial');

    //   await untilCalled(mockRepository.searchVideos(any));

    //   verify(mockRepository.searchVideos(argThat(equals('flutter tutorial'))));
    // });
  });
}
