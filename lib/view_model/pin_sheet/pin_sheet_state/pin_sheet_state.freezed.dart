// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_sheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PinSheetState {
  bool get isFocusOnPin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinSheetStateCopyWith<PinSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinSheetStateCopyWith<$Res> {
  factory $PinSheetStateCopyWith(
          PinSheetState value, $Res Function(PinSheetState) then) =
      _$PinSheetStateCopyWithImpl<$Res, PinSheetState>;
  @useResult
  $Res call({bool isFocusOnPin});
}

/// @nodoc
class _$PinSheetStateCopyWithImpl<$Res, $Val extends PinSheetState>
    implements $PinSheetStateCopyWith<$Res> {
  _$PinSheetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFocusOnPin = null,
  }) {
    return _then(_value.copyWith(
      isFocusOnPin: null == isFocusOnPin
          ? _value.isFocusOnPin
          : isFocusOnPin // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PinSheetStateCopyWith<$Res>
    implements $PinSheetStateCopyWith<$Res> {
  factory _$$_PinSheetStateCopyWith(
          _$_PinSheetState value, $Res Function(_$_PinSheetState) then) =
      __$$_PinSheetStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFocusOnPin});
}

/// @nodoc
class __$$_PinSheetStateCopyWithImpl<$Res>
    extends _$PinSheetStateCopyWithImpl<$Res, _$_PinSheetState>
    implements _$$_PinSheetStateCopyWith<$Res> {
  __$$_PinSheetStateCopyWithImpl(
      _$_PinSheetState _value, $Res Function(_$_PinSheetState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFocusOnPin = null,
  }) {
    return _then(_$_PinSheetState(
      isFocusOnPin: null == isFocusOnPin
          ? _value.isFocusOnPin
          : isFocusOnPin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PinSheetState implements _PinSheetState {
  const _$_PinSheetState({required this.isFocusOnPin});

  @override
  final bool isFocusOnPin;

  @override
  String toString() {
    return 'PinSheetState(isFocusOnPin: $isFocusOnPin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PinSheetState &&
            (identical(other.isFocusOnPin, isFocusOnPin) ||
                other.isFocusOnPin == isFocusOnPin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFocusOnPin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      __$$_PinSheetStateCopyWithImpl<_$_PinSheetState>(this, _$identity);
}

abstract class _PinSheetState implements PinSheetState {
  const factory _PinSheetState({required final bool isFocusOnPin}) =
      _$_PinSheetState;

  @override
  bool get isFocusOnPin;
  @override
  @JsonKey(ignore: true)
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}
