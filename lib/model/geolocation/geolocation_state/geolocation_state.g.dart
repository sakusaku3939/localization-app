// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeolocationState _$$_GeolocationStateFromJson(Map<String, dynamic> json) =>
    _$_GeolocationState(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      heading: (json['heading'] as num).toDouble(),
      headingAccuracy: (json['headingAccuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$$_GeolocationStateToJson(_$_GeolocationState instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'accuracy': instance.accuracy,
      'heading': instance.heading,
      'headingAccuracy': instance.headingAccuracy,
    };
