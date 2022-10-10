// ignore_for_file: invalid_annotation_target
import 'dart:ui';

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
@HiveType(typeId: 2, adapterName: 'PostModelAdapter')
class PostModel with _$PostModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory PostModel({
    // required List<CommentsModel> comments,
    @HiveField(0) @Default('') String textContent,
    @HiveField(1) @Default('') String postId,
    @HiveField(2) UserModel? creatorUser,
    @HiveField(3) @Default(false) bool isDarkText,
    @HiveField(4) @Default(false) bool isSubPost,
    @HiveField(5) @Default(false) bool enableLikes,
    @HiveField(6) @Default(false) bool enableComments,
    @HiveField(7) @DateTimeStampConv() DateTime? timestamp,
    @HiveField(8) @Default(TextAlign.center) TextAlign textAlign,
    @HiveField(9) int? likeCounter,
    @HiveField(10) String? photoCover,
    @HiveField(11) @ColorIntConv() Color? colorCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}


