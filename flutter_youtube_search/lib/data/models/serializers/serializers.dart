library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  YoutubeSearchResult,
  Id,
  SearchItem,
  SearchSnippet,
  Thumbnails,
  Thumbnail
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
