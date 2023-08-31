// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FloorMapState {
  List<LocationPin> get locationPins => throw _privateConstructorUsedError;
  PhotoViewController get photoController => throw _privateConstructorUsedError;
  bool get isEditMode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FloorMapStateCopyWith<FloorMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorMapStateCopyWith<$Res> {
  factory $FloorMapStateCopyWith(
          FloorMapState value, $Res Function(FloorMapState) then) =
      _$FloorMapStateCopyWithImpl<$Res, FloorMapState>;
  @useResult
  $Res call(
      {List<LocationPin> locationPins,
      PhotoViewController photoController,
      bool isEditMode});
}

/// @nodoc
class _$FloorMapStateCopyWithImpl<$Res, $Val extends FloorMapState>
    implements $FloorMapStateCopyWith<$Res> {
  _$FloorMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationPins = null,
    Object? photoController = null,
    Object? isEditMode = null,
  }) {
    return _then(_value.copyWith(
      locationPins: null == locationPins
          ? _value.locationPins
          : locationPins // ignore: cast_nullable_to_non_nullable
              as List<LocationPin>,
      photoController: null == photoController
          ? _value.photoController
          : photoController // ignore: cast_nullable_to_non_nullable
              as PhotoViewController,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FloorMapStateCopyWith<$Res>
    implements $FloorMapStateCopyWith<$Res> {
  factory _$$_FloorMapStateCopyWith(
          _$_FloorMapState value, $Res Function(_$_FloorMapState) then) =
      __$$_FloorMapStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LocationPin> locationPins,
      PhotoViewController photoController,
      bool isEditMode});
}

/// @nodoc
class __$$_FloorMapStateCopyWithImpl<$Res>
    extends _$FloorMapStateCopyWithImpl<$Res, _$_FloorMapState>
    implements _$$_FloorMapStateCopyWith<$Res> {
  __$$_FloorMapStateCopyWithImpl(
      _$_FloorMapState _value, $Res Function(_$_FloorMapState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationPins = null,
    Object? photoController = null,
    Object? isEditMode = null,
  }) {
    return _then(_$_FloorMapState(
      locationPins: null == locationPins
          ? _value._locationPins
          : locationPins // ignore: cast_nullable_to_non_nullable
              as List<LocationPin>,
      photoController: null == photoController
          ? _value.photoController
          : photoController // ignore: cast_nullable_to_non_nullable
              as PhotoViewController,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FloorMapState implements _FloorMapState {
  const _$_FloorMapState(
      {required final List<LocationPin> locationPins,
      required this.photoController,
      required this.isEditMode})
      : _locationPins = locationPins;

  final List<LocationPin> _locationPins;
  @override
  List<LocationPin> get locationPins {
    if (_locationPins is EqualUnmodifiableListView) return _locationPins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationPins);
  }

  @override
  final PhotoViewController photoController;
  @override
  final bool isEditMode;

  @override
  String toString() {
    return 'FloorMapState(locationPins: $locationPins, photoController: $photoController, isEditMode: $isEditMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FloorMapState &&
            const DeepCollectionEquality()
                .equals(other._locationPins, _locationPins) &&
            (identical(other.photoController, photoController) ||
                other.photoController == photoController) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_locationPins),
      photoController,
      isEditMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FloorMapStateCopyWith<_$_FloorMapState> get copyWith =>
      __$$_FloorMapStateCopyWithImpl<_$_FloorMapState>(this, _$identity);
}

abstract class _FloorMapState implements FloorMapState {
  const factory _FloorMapState(
      {required final List<LocationPin> locationPins,
      required final PhotoViewController photoController,
      required final bool isEditMode}) = _$_FloorMapState;

  @override
  List<LocationPin> get locationPins;
  @override
  PhotoViewController get photoController;
  @override
  bool get isEditMode;
  @override
  @JsonKey(ignore: true)
  _$$_FloorMapStateCopyWith<_$_FloorMapState> get copyWith =>
      throw _privateConstructorUsedError;
}
