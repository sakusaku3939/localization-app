// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationPin _$$_LocationPinFromJson(Map<String, dynamic> json) =>
    _$_LocationPin(
      id: json['id'] as String,
      x: json['x'] as int,
      y: json['y'] as int,
      pinLeft: (json['pinLeft'] as num).toDouble(),
      pinTop: (json['pinTop'] as num).toDouble(),
      size: (json['size'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LocationPinToJson(_$_LocationPin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
      'pinLeft': instance.pinLeft,
      'pinTop': instance.pinTop,
      'size': instance.size,
    };
