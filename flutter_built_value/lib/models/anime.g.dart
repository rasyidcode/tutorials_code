// GENERATED CODE - DO NOT MODIFY BY HAND

part of anime;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Anime extends Anime {
  factory _$Anime([void Function(AnimeBuilder)? updates]) =>
      (new AnimeBuilder()..update(updates)).build();

  _$Anime._() : super._();

  @override
  Anime rebuild(void Function(AnimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnimeBuilder toBuilder() => new AnimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Anime;
  }

  @override
  int get hashCode {
    return 8089672;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('Anime').toString();
  }
}

class AnimeBuilder implements Builder<Anime, AnimeBuilder> {
  _$Anime? _$v;

  AnimeBuilder();

  @override
  void replace(Anime other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Anime;
  }

  @override
  void update(void Function(AnimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Anime build() {
    final _$result = _$v ?? new _$Anime._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
