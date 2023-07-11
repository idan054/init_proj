// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PositionModel _$$_PositionModelFromJson(Map<String, dynamic> json) =>
    _$_PositionModel(
      geohash: json['geohash'] as String?,
      geopoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['geopoint'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$_PositionModelToJson(_$_PositionModel instance) =>
    <String, dynamic>{
      'geohash': instance.geohash,
      'geopoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.geopoint, const GeoPointConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
