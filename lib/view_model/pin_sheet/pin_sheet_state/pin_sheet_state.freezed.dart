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
  bool get isShow => throw _privateConstructorUsedError;
  int get pinX => throw _privateConstructorUsedError;
  int get pinY => throw _privateConstructorUsedError;

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
  $Res call({bool isShow, int pinX, int pinY});
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
    Object? isShow = null,
    Object? pinX = null,
    Object? pinY = null,
  }) {
    return _then(_value.copyWith(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      pinX: null == pinX
          ? _value.pinX
          : pinX // ignore: cast_nullable_to_non_nullable
              as int,
      pinY: null == pinY
          ? _value.pinY
          : pinY // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({bool isShow, int pinX, int pinY});
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
    Object? isShow = null,
    Object? pinX = null,
    Object? pinY = null,
  }) {
    return _then(_$_PinSheetState(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      pinX: null == pinX
          ? _value.pinX
          : pinX // ignore: cast_nullable_to_non_nullable
              as int,
      pinY: null == pinY
          ? _value.pinY
          : pinY // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PinSheetState implements _PinSheetState {
  const _$_PinSheetState(
      {required this.isShow, required this.pinX, required this.pinY});

  @override
  final bool isShow;
  @override
  final int pinX;
  @override
  final int pinY;

  @override
  String toString() {
    return 'PinSheetState(isShow: $isShow, pinX: $pinX, pinY: $pinY)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PinSheetState &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.pinX, pinX) || other.pinX == pinX) &&
            (identical(other.pinY, pinY) || other.pinY == pinY));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isShow, pinX, pinY);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      __$$_PinSheetStateCopyWithImpl<_$_PinSheetState>(this, _$identity);
}

abstract class _PinSheetState implements PinSheetState {
  const factory _PinSheetState(
      {required final bool isShow,
      required final int pinX,
      required final int pinY}) = _$_PinSheetState;

  @override
  bool get isShow;
  @override
  int get pinX;
  @override
  int get pinY;
  @override
  @JsonKey(ignore: true)
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}
