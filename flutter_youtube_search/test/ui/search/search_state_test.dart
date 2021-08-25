import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/ui/search/search.dart';

void main() {
  group('SearchState custom getter', () {
    late SearchState initial;
    late SearchState loading;
    late SearchState success;
    late SearchState failure;

    String fixture(String name) =>
        File('test/data/fixtures/$name.json').readAsStringSync();

    setUp(() {
      final searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result'))?.items;
      initial = SearchState.initial();
      loading = SearchState.loading();
      success = SearchState.success(searchResultList);
      failure = SearchState.failure('Test error');
    });

    test('isInitial returns true only when instantiated with initial factory',
        () {
      expect(initial.isInitial, true);
      expect(loading.isInitial, false);
      expect(success.isInitial, false);
      expect(failure.isInitial, false);
    });
    test(
        'isSuccessful returns true only when instantiated with success factory',
        () {
      expect(initial.isSuccessful, false);
      expect(loading.isSuccessful, false);
      expect(success.isSuccessful, true);
      expect(failure.isSuccessful, false);
    });
  });
}
