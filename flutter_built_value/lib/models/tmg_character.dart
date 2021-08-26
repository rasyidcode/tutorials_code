library tmg_character;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_built_value/models/serializers.dart';

part 'tmg_character.g.dart';

abstract class TMGCharacter
    implements Built<TMGCharacter, TMGCharacterBuilder> {
  String get japaneseName;
  String get romanjiName;
  BuiltList<String> get aliases;
  String? get born;
  SkinColor get skinColor;

  TMGCharacter._();

  factory TMGCharacter([updates(TMGCharacterBuilder b)]) = _$TMGCharacter;

  String toJson() {
    return json
        .encode(serializers.serializeWith(TMGCharacter.serializer, this));
  }

  static TMGCharacter? fromJson(String jsonString) {
    return serializers.deserializeWith(
        TMGCharacter.serializer, json.decode(jsonString));
  }

  static Serializer<TMGCharacter> get serializer => _$tMGCharacterSerializer;
}

class SkinColor extends EnumClass {
  static const SkinColor black = _$black;
  static const SkinColor brown = _$brown;
  static const SkinColor white = _$white;
  static const SkinColor red = _$red;

  const SkinColor._(String name) : super(name);

  static BuiltSet<SkinColor> get values => _$values;
  static SkinColor valueOf(String name) => _$valueOf(name);

  static Serializer<SkinColor> get serializer => _$skinColorSerializer;
}
