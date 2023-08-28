// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationPin _$$_LocationPinFromJson(Map<String, dynamic> json) =>
    _$_LocationPin(
      id: json['id'] as int,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      pinLeft: (json['pinLeft'] as num).toDouble(),
      pinTop: (json['pinTop'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LocationPinToJson(_$_LocationPin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
      'pinLeft': instance.pinLeft,
      'pinTop': instance.pinTop,
    };
