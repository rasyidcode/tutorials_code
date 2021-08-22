library thumbnails;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:github_user_searcch/data/models/search/model_search.dart';
import 'package:github_user_searcch/data/models/serializers/serializers.dart';

part 'thumbnails.g.dart';

abstract class Thumbnails implements Built<Thumbnails, ThumbnailsBuilder> {
  // fields go here
  @BuiltValueField(wireName: 'default')
  Thumbnail get imgDefault;
  Thumbnail get medium;
  Thumbnail get high;
  Thumbnails._();

  factory Thumbnails([updates(ThumbnailsBuilder b)]) = _$Thumbnails;

  String toJson() {
    return json.encode(serializers.serializeWith(Thumbnails.serializer, this));
  }

  static Thumbnails? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thumbnails.serializer, json.decode(jsonString));
  }

  static Serializer<Thumbnails> get serializer => _$thumbnailsSerializer;
}
