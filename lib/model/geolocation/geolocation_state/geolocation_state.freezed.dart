// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geolocation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeolocationState _$GeolocationStateFromJson(Map<String, dynamic> json) {
  return _GeolocationState.fromJson(json);
}

/// @nodoc
mixin _$GeolocationState {
  double get longitude => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  double get heading => throw _privateConstructorUsedError;
  double get headingAccuracy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeolocationStateCopyWith<GeolocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeolocationStateCopyWith<$Res> {
  factory $GeolocationStateCopyWith(
          GeolocationState value, $Res Function(GeolocationState) then) =
      _$GeolocationStateCopyWithImpl<$Res, GeolocationState>;
  @useResult
  $Res call(
      {double longitude,
      double latitude,
      double accuracy,
      double heading,
      double headingAccuracy});
}

/// @nodoc
class _$GeolocationStateCopyWithImpl<$Res, $Val extends GeolocationState>
    implements $GeolocationStateCopyWith<$Res> {
  _$GeolocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longitude = null,
    Object? latitude = null,
    Object? accuracy = null,
    Object? heading = null,
    Object? headingAccuracy = null,
  }) {
    return _then(_value.copyWith(
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      heading: null == heading
          ? _value.heading
          : heading // ignore: cast_nullable_to_non_nullable
              as double,
      headingAccuracy: null == headingAccuracy
          ? _value.headingAccuracy
          : headingAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GeolocationStateCopyWith<$Res>
    implements $GeolocationStateCopyWith<$Res> {
  factory _$$_GeolocationStateCopyWith(
          _$_GeolocationState value, $Res Function(_$_GeolocationState) then) =
      __$$_GeolocationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double longitude,
      double latitude,
      double accuracy,
      double heading,
      double headingAccuracy});
}

/// @nodoc
class __$$_GeolocationStateCopyWithImpl<$Res>
    extends _$GeolocationStateCopyWithImpl<$Res, _$_GeolocationState>
    implements _$$_GeolocationStateCopyWith<$Res> {
  __$$_GeolocationStateCopyWithImpl(
      _$_GeolocationState _value, $Res Function(_$_GeolocationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longitude = null,
    Object? latitude = null,
    Object? accuracy = null,
    Object? heading = null,
    Object? headingAccuracy = null,
  }) {
    return _then(_$_GeolocationState(
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      heading: null == heading
          ? _value.heading
          : heading // ignore: cast_nullable_to_non_nullable
              as double,
      headingAccuracy: null == headingAccuracy
          ? _value.headingAccuracy
          : headingAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeolocationState implements _GeolocationState {
  const _$_GeolocationState(
      {required this.longitude,
      required this.latitude,
      required this.accuracy,
      required this.heading,
      required this.headingAccuracy});

  factory _$_GeolocationState.fromJson(Map<String, dynamic> json) =>
      _$$_GeolocationStateFromJson(json);

  @override
  final double longitude;
  @override
  final double latitude;
  @override
  final double accuracy;
  @override
  final double heading;
  @override
  final double headingAccuracy;

  @override
  String toString() {
    return 'GeolocationState(longitude: $longitude, latitude: $latitude, accuracy: $accuracy, heading: $heading, headingAccuracy: $headingAccuracy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeolocationState &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.headingAccuracy, headingAccuracy) ||
                other.headingAccuracy == headingAccuracy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, longitude, latitude, accuracy, heading, headingAccuracy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GeolocationStateCopyWith<_$_GeolocationState> get copyWith =>
      __$$_GeolocationStateCopyWithImpl<_$_GeolocationState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeolocationStateToJson(
      this,
    );
  }
}

abstract class _GeolocationState implements GeolocationState {
  const factory _GeolocationState(
      {required final double longitude,
      required final double latitude,
      required final double accuracy,
      required final double heading,
      required final double headingAccuracy}) = _$_GeolocationState;

  factory _GeolocationState.fromJson(Map<String, dynamic> json) =
      _$_GeolocationState.fromJson;

  @override
  double get longitude;
  @override
  double get latitude;
  @override
  double get accuracy;
  @override
  double get heading;
  @override
  double get headingAccuracy;
  @override
  @JsonKey(ignore: true)
  _$$_GeolocationStateCopyWith<_$_GeolocationState> get copyWith =>
      throw _privateConstructorUsedError;
}
