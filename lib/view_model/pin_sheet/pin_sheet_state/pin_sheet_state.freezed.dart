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
  bool get isPredict => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get mapX => throw _privateConstructorUsedError;
  int get mapY => throw _privateConstructorUsedError;
  List<Reference>? get storageRefList => throw _privateConstructorUsedError;
  String? get resultImageUrl => throw _privateConstructorUsedError;

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
  $Res call(
      {bool isShow,
      bool isPredict,
      String id,
      int mapX,
      int mapY,
      List<Reference>? storageRefList,
      String? resultImageUrl});
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
    Object? isPredict = null,
    Object? id = null,
    Object? mapX = null,
    Object? mapY = null,
    Object? storageRefList = freezed,
    Object? resultImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isPredict: null == isPredict
          ? _value.isPredict
          : isPredict // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mapX: null == mapX
          ? _value.mapX
          : mapX // ignore: cast_nullable_to_non_nullable
              as int,
      mapY: null == mapY
          ? _value.mapY
          : mapY // ignore: cast_nullable_to_non_nullable
              as int,
      storageRefList: freezed == storageRefList
          ? _value.storageRefList
          : storageRefList // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      resultImageUrl: freezed == resultImageUrl
          ? _value.resultImageUrl
          : resultImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call(
      {bool isShow,
      bool isPredict,
      String id,
      int mapX,
      int mapY,
      List<Reference>? storageRefList,
      String? resultImageUrl});
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
    Object? isPredict = null,
    Object? id = null,
    Object? mapX = null,
    Object? mapY = null,
    Object? storageRefList = freezed,
    Object? resultImageUrl = freezed,
  }) {
    return _then(_$_PinSheetState(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isPredict: null == isPredict
          ? _value.isPredict
          : isPredict // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mapX: null == mapX
          ? _value.mapX
          : mapX // ignore: cast_nullable_to_non_nullable
              as int,
      mapY: null == mapY
          ? _value.mapY
          : mapY // ignore: cast_nullable_to_non_nullable
              as int,
      storageRefList: freezed == storageRefList
          ? _value._storageRefList
          : storageRefList // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      resultImageUrl: freezed == resultImageUrl
          ? _value.resultImageUrl
          : resultImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PinSheetState implements _PinSheetState {
  const _$_PinSheetState(
      {required this.isShow,
      required this.isPredict,
      required this.id,
      required this.mapX,
      required this.mapY,
      required final List<Reference>? storageRefList,
      this.resultImageUrl})
      : _storageRefList = storageRefList;

  @override
  final bool isShow;
  @override
  final bool isPredict;
  @override
  final String id;
  @override
  final int mapX;
  @override
  final int mapY;
  final List<Reference>? _storageRefList;
  @override
  List<Reference>? get storageRefList {
    final value = _storageRefList;
    if (value == null) return null;
    if (_storageRefList is EqualUnmodifiableListView) return _storageRefList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? resultImageUrl;

  @override
  String toString() {
    return 'PinSheetState(isShow: $isShow, isPredict: $isPredict, id: $id, mapX: $mapX, mapY: $mapY, storageRefList: $storageRefList, resultImageUrl: $resultImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PinSheetState &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.isPredict, isPredict) ||
                other.isPredict == isPredict) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mapX, mapX) || other.mapX == mapX) &&
            (identical(other.mapY, mapY) || other.mapY == mapY) &&
            const DeepCollectionEquality()
                .equals(other._storageRefList, _storageRefList) &&
            (identical(other.resultImageUrl, resultImageUrl) ||
                other.resultImageUrl == resultImageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isShow,
      isPredict,
      id,
      mapX,
      mapY,
      const DeepCollectionEquality().hash(_storageRefList),
      resultImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      __$$_PinSheetStateCopyWithImpl<_$_PinSheetState>(this, _$identity);
}

abstract class _PinSheetState implements PinSheetState {
  const factory _PinSheetState(
      {required final bool isShow,
      required final bool isPredict,
      required final String id,
      required final int mapX,
      required final int mapY,
      required final List<Reference>? storageRefList,
      final String? resultImageUrl}) = _$_PinSheetState;

  @override
  bool get isShow;
  @override
  bool get isPredict;
  @override
  String get id;
  @override
  int get mapX;
  @override
  int get mapY;
  @override
  List<Reference>? get storageRefList;
  @override
  String? get resultImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PinSheetStateCopyWith<_$_PinSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}
