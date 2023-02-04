// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/message/message_model.dart';
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
    String? tag,
    UserModel? creatorUser,
    @Default('') String textContent,
    @Default('') String id,
    @Default([]) List<String> likeByIds,
    @DateTimeStampConv() DateTime? timestamp,
    @Default(false) bool enableComments,
    // @ColorIntConv() Color? colorCover,

    //~ Also use as comment, Comment variables:
    String? originalPostId,
    @Default(0) int commentsLength,
    @Default([]) List<String> commentedUsersEmails, // AKA conversion users
    @Default([]) List<PostModel>? comments,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}


