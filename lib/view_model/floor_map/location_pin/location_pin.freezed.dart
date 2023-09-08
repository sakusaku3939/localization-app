// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocationPin _$LocationPinFromJson(Map<String, dynamic> json) {
  return _LocationPin.fromJson(json);
}

/// @nodoc
mixin _$LocationPin {
  int get id => throw _privateConstructorUsedError;
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  double get pinLeft => throw _privateConstructorUsedError;
  double get pinTop => throw _privateConstructorUsedError;
  double get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationPinCopyWith<LocationPin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPinCopyWith<$Res> {
  factory $LocationPinCopyWith(
          LocationPin value, $Res Function(LocationPin) then) =
      _$LocationPinCopyWithImpl<$Res, LocationPin>;
  @useResult
  $Res call({int id, int x, int y, double pinLeft, double pinTop, double size});
}

/// @nodoc
class _$LocationPinCopyWithImpl<$Res, $Val extends LocationPin>
    implements $LocationPinCopyWith<$Res> {
  _$LocationPinCopyWithImpl(this._value, this._then);

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
    Object? pinLeft = null,
    Object? pinTop = null,
    Object? size = null,
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
      pinLeft: null == pinLeft
          ? _value.pinLeft
          : pinLeft // ignore: cast_nullable_to_non_nullable
              as double,
      pinTop: null == pinTop
          ? _value.pinTop
          : pinTop // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationPinCopyWith<$Res>
    implements $LocationPinCopyWith<$Res> {
  factory _$$_LocationPinCopyWith(
          _$_LocationPin value, $Res Function(_$_LocationPin) then) =
      __$$_LocationPinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int x, int y, double pinLeft, double pinTop, double size});
}

/// @nodoc
class __$$_LocationPinCopyWithImpl<$Res>
    extends _$LocationPinCopyWithImpl<$Res, _$_LocationPin>
    implements _$$_LocationPinCopyWith<$Res> {
  __$$_LocationPinCopyWithImpl(
      _$_LocationPin _value, $Res Function(_$_LocationPin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? x = null,
    Object? y = null,
    Object? pinLeft = null,
    Object? pinTop = null,
    Object? size = null,
  }) {
    return _then(_$_LocationPin(
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
      pinLeft: null == pinLeft
          ? _value.pinLeft
          : pinLeft // ignore: cast_nullable_to_non_nullable
              as double,
      pinTop: null == pinTop
          ? _value.pinTop
          : pinTop // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationPin implements _LocationPin {
  const _$_LocationPin(
      {required this.id,
      required this.x,
      required this.y,
      required this.pinLeft,
      required this.pinTop,
      required this.size});

  factory _$_LocationPin.fromJson(Map<String, dynamic> json) =>
      _$$_LocationPinFromJson(json);

  @override
  final int id;
  @override
  final int x;
  @override
  final int y;
  @override
  final double pinLeft;
  @override
  final double pinTop;
  @override
  final double size;

  @override
  String toString() {
    return 'LocationPin(id: $id, x: $x, y: $y, pinLeft: $pinLeft, pinTop: $pinTop, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationPin &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.pinLeft, pinLeft) || other.pinLeft == pinLeft) &&
            (identical(other.pinTop, pinTop) || other.pinTop == pinTop) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, x, y, pinLeft, pinTop, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationPinCopyWith<_$_LocationPin> get copyWith =>
      __$$_LocationPinCopyWithImpl<_$_LocationPin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationPinToJson(
      this,
    );
  }
}

abstract class _LocationPin implements LocationPin {
  const factory _LocationPin(
      {required final int id,
      required final int x,
      required final int y,
      required final double pinLeft,
      required final double pinTop,
      required final double size}) = _$_LocationPin;

  factory _LocationPin.fromJson(Map<String, dynamic> json) =
      _$_LocationPin.fromJson;

  @override
  int get id;
  @override
  int get x;
  @override
  int get y;
  @override
  double get pinLeft;
  @override
  double get pinTop;
  @override
  double get size;
  @override
  @JsonKey(ignore: true)
  _$$_LocationPinCopyWith<_$_LocationPin> get copyWith =>
      throw _privateConstructorUsedError;
}
