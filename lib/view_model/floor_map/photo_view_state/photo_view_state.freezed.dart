// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhotoViewState _$PhotoViewStateFromJson(Map<String, dynamic> json) {
  return _PhotoViewState.fromJson(json);
}

/// @nodoc
mixin _$PhotoViewState {
  double get dx => throw _privateConstructorUsedError;
  double get dy => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  double get defaultImageScale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoViewStateCopyWith<PhotoViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoViewStateCopyWith<$Res> {
  factory $PhotoViewStateCopyWith(
          PhotoViewState value, $Res Function(PhotoViewState) then) =
      _$PhotoViewStateCopyWithImpl<$Res, PhotoViewState>;
  @useResult
  $Res call(
      {double dx,
      double dy,
      double width,
      double height,
      double scale,
      double defaultImageScale});
}

/// @nodoc
class _$PhotoViewStateCopyWithImpl<$Res, $Val extends PhotoViewState>
    implements $PhotoViewStateCopyWith<$Res> {
  _$PhotoViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? width = null,
    Object? height = null,
    Object? scale = null,
    Object? defaultImageScale = null,
  }) {
    return _then(_value.copyWith(
      dx: null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      dy: null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      defaultImageScale: null == defaultImageScale
          ? _value.defaultImageScale
          : defaultImageScale // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotoViewStateCopyWith<$Res>
    implements $PhotoViewStateCopyWith<$Res> {
  factory _$$_PhotoViewStateCopyWith(
          _$_PhotoViewState value, $Res Function(_$_PhotoViewState) then) =
      __$$_PhotoViewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double dx,
      double dy,
      double width,
      double height,
      double scale,
      double defaultImageScale});
}

/// @nodoc
class __$$_PhotoViewStateCopyWithImpl<$Res>
    extends _$PhotoViewStateCopyWithImpl<$Res, _$_PhotoViewState>
    implements _$$_PhotoViewStateCopyWith<$Res> {
  __$$_PhotoViewStateCopyWithImpl(
      _$_PhotoViewState _value, $Res Function(_$_PhotoViewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? width = null,
    Object? height = null,
    Object? scale = null,
    Object? defaultImageScale = null,
  }) {
    return _then(_$_PhotoViewState(
      dx: null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      dy: null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      defaultImageScale: null == defaultImageScale
          ? _value.defaultImageScale
          : defaultImageScale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PhotoViewState implements _PhotoViewState {
  const _$_PhotoViewState(
      {required this.dx,
      required this.dy,
      required this.width,
      required this.height,
      required this.scale,
      required this.defaultImageScale});

  factory _$_PhotoViewState.fromJson(Map<String, dynamic> json) =>
      _$$_PhotoViewStateFromJson(json);

  @override
  final double dx;
  @override
  final double dy;
  @override
  final double width;
  @override
  final double height;
  @override
  final double scale;
  @override
  final double defaultImageScale;

  @override
  String toString() {
    return 'PhotoViewState(dx: $dx, dy: $dy, width: $width, height: $height, scale: $scale, defaultImageScale: $defaultImageScale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotoViewState &&
            (identical(other.dx, dx) || other.dx == dx) &&
            (identical(other.dy, dy) || other.dy == dy) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.defaultImageScale, defaultImageScale) ||
                other.defaultImageScale == defaultImageScale));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, dx, dy, width, height, scale, defaultImageScale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotoViewStateCopyWith<_$_PhotoViewState> get copyWith =>
      __$$_PhotoViewStateCopyWithImpl<_$_PhotoViewState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotoViewStateToJson(
      this,
    );
  }
}

abstract class _PhotoViewState implements PhotoViewState {
  const factory _PhotoViewState(
      {required final double dx,
      required final double dy,
      required final double width,
      required final double height,
      required final double scale,
      required final double defaultImageScale}) = _$_PhotoViewState;

  factory _PhotoViewState.fromJson(Map<String, dynamic> json) =
      _$_PhotoViewState.fromJson;

  @override
  double get dx;
  @override
  double get dy;
  @override
  double get width;
  @override
  double get height;
  @override
  double get scale;
  @override
  double get defaultImageScale;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoViewStateCopyWith<_$_PhotoViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
