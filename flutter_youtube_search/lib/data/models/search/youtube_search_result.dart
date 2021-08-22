library youtube_search_result;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/models/serializers/serializers.dart';

part 'youtube_search_result.g.dart';

abstract class YoutubeSearchResult
    implements Built<YoutubeSearchResult, YoutubeSearchResultBuilder> {
  // fields go here
  String? get nextPageToken;
  BuiltList<SearchItem> get items;

  YoutubeSearchResult._();

  factory YoutubeSearchResult([updates(YoutubeSearchResultBuilder b)]) =
      _$YoutubeSearchResult;

  String toJson() {
    return json.encode(
        serializers.serializeWith(YoutubeSearchResult.serializer, this));
  }

  static YoutubeSearchResult? fromJson(String jsonString) {
    return serializers.deserializeWith(
        YoutubeSearchResult.serializer, json.decode(jsonString));
  }

  static Serializer<YoutubeSearchResult> get serializer =>
      _$youtubeSearchResultSerializer;
}
