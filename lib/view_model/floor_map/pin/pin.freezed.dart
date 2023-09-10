// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pin _$PinFromJson(Map<String, dynamic> json) {
  return _Pin.fromJson(json);
}

/// @nodoc
mixin _$Pin {
  int get id => throw _privateConstructorUsedError;
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PinCopyWith<Pin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinCopyWith<$Res> {
  factory $PinCopyWith(Pin value, $Res Function(Pin) then) =
      _$PinCopyWithImpl<$Res, Pin>;
  @useResult
  $Res call({int id, int x, int y});
}

/// @nodoc
class _$PinCopyWithImpl<$Res, $Val extends Pin> implements $PinCopyWith<$Res> {
  _$PinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PinCopyWith<$Res> implements $PinCopyWith<$Res> {
  factory _$$_PinCopyWith(_$_Pin value, $Res Function(_$_Pin) then) =
      __$$_PinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int x, int y});
}

/// @nodoc
class __$$_PinCopyWithImpl<$Res> extends _$PinCopyWithImpl<$Res, _$_Pin>
    implements _$$_PinCopyWith<$Res> {
  __$$_PinCopyWithImpl(_$_Pin _value, $Res Function(_$_Pin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$_Pin(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pin implements _Pin {
  const _$_Pin({required this.id, required this.x, required this.y});

  factory _$_Pin.fromJson(Map<String, dynamic> json) => _$$_PinFromJson(json);

  @override
  final int id;
  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'Pin(id: $id, x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pin &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinCopyWith<_$_Pin> get copyWith =>
      __$$_PinCopyWithImpl<_$_Pin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PinToJson(
      this,
    );
  }
}

abstract class _Pin implements Pin {
  const factory _Pin(
      {required final int id,
      required final int x,
      required final int y}) = _$_Pin;

  factory _Pin.fromJson(Map<String, dynamic> json) = _$_Pin.fromJson;

  @override
  int get id;
  @override
  int get x;
  @override
  int get y;
  @override
  @JsonKey(ignore: true)
  _$$_PinCopyWith<_$_Pin> get copyWith => throw _privateConstructorUsedError;
}
