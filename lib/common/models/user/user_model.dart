// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

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
    String? photoUrl,
    @Default(0) int unreadCounter,
    @Default(0) int unreadNotificationCounter,
    GenderTypes? gender,
    @Default(UserTypes.normal) UserTypes? userType,
    @Default([]) List<String> tags,
    @Default([]) List<String> blockedUsers,
    @Default(false) bool isOnline,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
