import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user_model.g.dart';
part 'user_model.freezed.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

}



