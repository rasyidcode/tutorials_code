import 'dart:convert';

import 'package:github_user_searcch/api_key.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/models/search/youtube_search_error.dart';
import 'package:http/http.dart' as http;

const MAX_SEARCH_RESULT = 5;

class YoutubeDataSource {
  final http.Client client;
  final String _searchBaseUrl =
      'https://youtube.googleapis.com/youtube/v3/search?part=snippet&' +
          'maxResults=$MAX_SEARCH_RESULT&key=$YOUTUBE_API_KEY';
  YoutubeDataSource(this.client);

  Future<YoutubeSearchResult?> searchVideos({
    required String query,
    String pageToken = '',
  }) async {
    final urlRaw = _searchBaseUrl +
        '&q=$query' +
        (pageToken.isNotEmpty ? '&pageToken=$pageToken' : '');
    final urlEncoded = Uri.encodeFull(urlRaw);
    final response = await client.get(Uri.parse(urlEncoded));

    if (response.statusCode == 200) {
      return YoutubeSearchResult.fromJson(response.body);
    } else {
      throw YoutubeSearchError(jsonDecode(response.body)['error']['message']);
    }
  }
}
