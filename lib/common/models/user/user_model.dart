// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../convertors.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@HiveType(typeId: 5)
enum GenderTypes {
  @HiveField(0) boy,
  @HiveField(1) girl,
  @HiveField(2) lgbt }

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
@HiveType(typeId: 1, adapterName: 'UserModelAdapter')
class UserModel with _$UserModel {
  // @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory UserModel({
    @HiveField(0) String? name,
    @HiveField(1) String? email,
    @HiveField(2) String? uid,
    @HiveField(3) int? age,
    @HiveField(4) String? photoUrl,
    @HiveField(5) GenderTypes? gender,
    @HiveField(6) @DateTimeStampConv() DateTime? birthday,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
