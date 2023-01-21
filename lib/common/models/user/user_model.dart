// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum GenderTypes { male, female, other}


// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
//~ Don't forget to manually add in HIVE Model!
class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes Only
  const factory UserModel({
    String? name,
    String? email,
    String? uid,
    String? bio,
    int? age,
    String? photoUrl,
    bool? isOnline,
    // int? userScore, // Example: 0 = Block Forever.
    GenderTypes? gender,
    @Default([]) List<String> tags,
    @DateTimeStampConv() DateTime? birthday,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
