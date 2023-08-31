// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_view_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhotoViewState _$$_PhotoViewStateFromJson(Map<String, dynamic> json) =>
    _$_PhotoViewState(
      dx: (json['dx'] as num).toDouble(),
      dy: (json['dy'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      scale: (json['scale'] as num).toDouble(),
      defaultImageScale: (json['defaultImageScale'] as num).toDouble(),
    );

Map<String, dynamic> _$$_PhotoViewStateToJson(_$_PhotoViewState instance) =>
    <String, dynamic>{
      'dx': instance.dx,
      'dy': instance.dy,
      'width': instance.width,
      'height': instance.height,
      'scale': instance.scale,
      'defaultImageScale': instance.defaultImageScale,
    };
