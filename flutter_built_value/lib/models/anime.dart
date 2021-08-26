library anime;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'anime.g.dart';

abstract class Anime implements Built<Anime, AnimeBuilder> {
  // fields go here

  Anime._();

  factory Anime([updates(AnimeBuilder b)]) = _$Anime;
}
