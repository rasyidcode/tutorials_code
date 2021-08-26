// GENERATED CODE - DO NOT MODIFY BY HAND

part of tmg_character;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SkinColor _$black = const SkinColor._('black');
const SkinColor _$brown = const SkinColor._('brown');
const SkinColor _$white = const SkinColor._('white');
const SkinColor _$red = const SkinColor._('red');

SkinColor _$valueOf(String name) {
  switch (name) {
    case 'black':
      return _$black;
    case 'brown':
      return _$brown;
    case 'white':
      return _$white;
    case 'red':
      return _$red;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SkinColor> _$values = new BuiltSet<SkinColor>(const <SkinColor>[
  _$black,
  _$brown,
  _$white,
  _$red,
]);

Serializer<TMGCharacter> _$tMGCharacterSerializer =
    new _$TMGCharacterSerializer();
Serializer<SkinColor> _$skinColorSerializer = new _$SkinColorSerializer();

class _$TMGCharacterSerializer implements StructuredSerializer<TMGCharacter> {
  @override
  final Iterable<Type> types = const [TMGCharacter, _$TMGCharacter];
  @override
  final String wireName = 'TMGCharacter';

  @override
  Iterable<Object?> serialize(Serializers serializers, TMGCharacter object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'japaneseName',
      serializers.serialize(object.japaneseName,
          specifiedType: const FullType(String)),
      'romanjiName',
      serializers.serialize(object.romanjiName,
          specifiedType: const FullType(String)),
      'aliases',
      serializers.serialize(object.aliases,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'skinColor',
      serializers.serialize(object.skinColor,
          specifiedType: const FullType(SkinColor)),
    ];
    Object? value;
    value = object.born;
    if (value != null) {
      result
        ..add('born')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TMGCharacter deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TMGCharacterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'japaneseName':
          result.japaneseName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'romanjiName':
          result.romanjiName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'aliases':
          result.aliases.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'born':
          result.born = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'skinColor':
          result.skinColor = serializers.deserialize(value,
              specifiedType: const FullType(SkinColor)) as SkinColor;
          break;
      }
    }

    return result.build();
  }
}

class _$SkinColorSerializer implements PrimitiveSerializer<SkinColor> {
  @override
  final Iterable<Type> types = const <Type>[SkinColor];
  @override
  final String wireName = 'SkinColor';

  @override
  Object serialize(Serializers serializers, SkinColor object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SkinColor deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SkinColor.valueOf(serialized as String);
}

class _$TMGCharacter extends TMGCharacter {
  @override
  final String japaneseName;
  @override
  final String romanjiName;
  @override
  final BuiltList<String> aliases;
  @override
  final String? born;
  @override
  final SkinColor skinColor;

  factory _$TMGCharacter([void Function(TMGCharacterBuilder)? updates]) =>
      (new TMGCharacterBuilder()..update(updates)).build();

  _$TMGCharacter._(
      {required this.japaneseName,
      required this.romanjiName,
      required this.aliases,
      this.born,
      required this.skinColor})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        japaneseName, 'TMGCharacter', 'japaneseName');
    BuiltValueNullFieldError.checkNotNull(
        romanjiName, 'TMGCharacter', 'romanjiName');
    BuiltValueNullFieldError.checkNotNull(aliases, 'TMGCharacter', 'aliases');
    BuiltValueNullFieldError.checkNotNull(
        skinColor, 'TMGCharacter', 'skinColor');
  }

  @override
  TMGCharacter rebuild(void Function(TMGCharacterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TMGCharacterBuilder toBuilder() => new TMGCharacterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TMGCharacter &&
        japaneseName == other.japaneseName &&
        romanjiName == other.romanjiName &&
        aliases == other.aliases &&
        born == other.born &&
        skinColor == other.skinColor;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, japaneseName.hashCode), romanjiName.hashCode),
                aliases.hashCode),
            born.hashCode),
        skinColor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TMGCharacter')
          ..add('japaneseName', japaneseName)
          ..add('romanjiName', romanjiName)
          ..add('aliases', aliases)
          ..add('born', born)
          ..add('skinColor', skinColor))
        .toString();
  }
}

class TMGCharacterBuilder
    implements Builder<TMGCharacter, TMGCharacterBuilder> {
  _$TMGCharacter? _$v;

  String? _japaneseName;
  String? get japaneseName => _$this._japaneseName;
  set japaneseName(String? japaneseName) => _$this._japaneseName = japaneseName;

  String? _romanjiName;
  String? get romanjiName => _$this._romanjiName;
  set romanjiName(String? romanjiName) => _$this._romanjiName = romanjiName;

  ListBuilder<String>? _aliases;
  ListBuilder<String> get aliases =>
      _$this._aliases ??= new ListBuilder<String>();
  set aliases(ListBuilder<String>? aliases) => _$this._aliases = aliases;

  String? _born;
  String? get born => _$this._born;
  set born(String? born) => _$this._born = born;

  SkinColor? _skinColor;
  SkinColor? get skinColor => _$this._skinColor;
  set skinColor(SkinColor? skinColor) => _$this._skinColor = skinColor;

  TMGCharacterBuilder();

  TMGCharacterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _japaneseName = $v.japaneseName;
      _romanjiName = $v.romanjiName;
      _aliases = $v.aliases.toBuilder();
      _born = $v.born;
      _skinColor = $v.skinColor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TMGCharacter other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TMGCharacter;
  }

  @override
  void update(void Function(TMGCharacterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TMGCharacter build() {
    _$TMGCharacter _$result;
    try {
      _$result = _$v ??
          new _$TMGCharacter._(
              japaneseName: BuiltValueNullFieldError.checkNotNull(
                  japaneseName, 'TMGCharacter', 'japaneseName'),
              romanjiName: BuiltValueNullFieldError.checkNotNull(
                  romanjiName, 'TMGCharacter', 'romanjiName'),
              aliases: aliases.build(),
              born: born,
              skinColor: BuiltValueNullFieldError.checkNotNull(
                  skinColor, 'TMGCharacter', 'skinColor'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'aliases';
        aliases.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TMGCharacter', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
