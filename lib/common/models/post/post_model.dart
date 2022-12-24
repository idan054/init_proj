// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
import '../user/user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class PostModel with _$PostModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory PostModel({
    @Default('') String textContent,
    @Default('') String id,
    UserModel? creatorUser,
    @Default([]) List<String> likeByIds,
    @DateTimeStampConv() DateTime? timestamp,
    @Default(false) bool isSubPost,
    @Default(false) bool enableComments,
    // required List<CommentsModel> comments,
    // @ColorIntConv() Color? colorCover,
    // String? photoCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}


