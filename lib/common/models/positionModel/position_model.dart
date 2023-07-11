// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';

part 'position_model.freezed.dart';

part 'position_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@Freezed(toJson: true)
//~ Don't forget to manually add in HIVE Model!
class PositionModel with _$PositionModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory PositionModel({
    @JsonKey(name: 'geohash') String? geohash,
    @JsonKey(name: 'geopoint') @GeoPointConverter() GeoPoint? geopoint,
  }) = _PositionModel;

  factory PositionModel.fromJson(Map<String, dynamic> json) => _$PositionModelFromJson(json);
}
