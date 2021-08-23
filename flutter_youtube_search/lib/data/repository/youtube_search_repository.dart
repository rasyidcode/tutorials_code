import 'package:built_collection/built_collection.dart';
import 'package:github_user_searcch/data/models/search/search_item.dart';
import 'package:github_user_searcch/data/network/youtube_data_source.dart';

class YoutubeSearchRepository {
  YoutubeDataSource _youtubeDataSource;

  String? _searchQuery;
  String? _pageToken;

  YoutubeSearchRepository(this._youtubeDataSource);

  Future<BuiltList<SearchItem>> searchVideos(String query) async {
    final searchResult = await _youtubeDataSource.searchVideos(query: query);

    if (searchResult == null) throw NullSearchResultException();
    if (searchResult.items.isEmpty) throw NoSearchResultsException();

    cacheValues(query: query, nextPageToken: searchResult.nextPageToken);

    return searchResult.items;
  }

  Future<BuiltList<SearchItem>> fetchNextVideos() async {
    if (_searchQuery == null) throw SearchNotInitException();
    if (_pageToken == null) throw NoNextPageTokenException();

    final nextSearchResult = await _youtubeDataSource.searchVideos(
        query: _searchQuery!, pageToken: _pageToken!);

    if (nextSearchResult == null) throw NullSearchResultException();

    cacheValues(query: _searchQuery, nextPageToken: _pageToken);

    return nextSearchResult.items;
  }

  void cacheValues({String? query, String? nextPageToken}) {
    _searchQuery = query;
    _pageToken = nextPageToken;
  }
}

class NoSearchResultsException implements Exception {
  final message = 'No result found';
}

class NoNextPageTokenException implements Exception {}

class SearchNotInitException implements Exception {
  final message = 'Cannot get the next result page without searching first';
}

class NoSuchVideoException implements Exception {
  final message = 'No such video ';
}

class NullSearchResultException implements Exception {
  final message = 'Search videos returns null';
}
