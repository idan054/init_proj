// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../convertors.dart';
import '../positionModel/position_model.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

enum GenderTypes { male, female, other }

enum UserTypes { normal, admin, blocked }

// flutter pub run build_runner build --delete-conflicting-outputs
@Freezed(toJson: true)
//~ Don't forget to manually add in HIVE Model!
class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory UserModel({
    String? uid,
    String? name,
    String? email,
    String? bio,
    String? fcm,
    int? age,
    @Default('https://www.bescouts.org.uk/wp-content/uploads/2022/10/person-placeholder.png') String photoUrl,
    @Default(0) int unreadCounter,
    @Default(0) int unreadNotificationCounter,
    GenderTypes? gender,
    @Default(UserTypes.normal) UserTypes? userType,
    @Default([]) List<String> tags,
    @Default([]) List<String> blockedUsers, // Hide content from (server based)
    @DateTimeStampConv() DateTime? birthday,
    PositionModel? position,
    // double? lat, // lastSeen Latitude
    // double? long, // lastSeen Longitude
    // @JsonKey(name: 'geopoint') @GeoPointConverter() GeoFirePoint? location,
    // @DateTimeStampConv() DateTime? lastActivity,
    @Default(false) bool isOnline,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
