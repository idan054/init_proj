// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../convertors.dart';
import '../user/user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@freezed
//~ Don't forget to manually add in HIVE Model!
class PostModel with _$PostModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory PostModel({
    // required List<CommentsModel> comments,
    @Default('') String textContent,
    @Default('') String postId,
    UserModel? creatorUser,
    @Default(false) bool isDarkText,
    @Default(false) bool isSubPost,
    @Default(false) bool enableLikes,
    @Default(false) bool enableComments,
    @DateTimeStampConv() DateTime? timestamp,
    @Default('') String textAlign,
    int? likeCounter,
    String? photoCover,
    @ColorIntConv() Color? colorCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}


