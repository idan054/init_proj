// ignore_for_file: invalid_annotation_target
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class PostModel with _$PostModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory PostModel({
    // required List<CommentsModel> comments,
    required String textContent,
    required String postId,
    required UserModel creatorUser,
    required bool isDarkText,
    required bool isSubPost,
    required bool enableLikes,
    required bool enableComments,
    required DateTime timestamp,
    @Default(TextAlign.center) TextAlign textAlign,
    int? likeCounter,
    String? photoCover,
    @MyColorOrNullConverter() Color? colorCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// Todo create a DateTime convertor.
class MyColorOrNullConverter implements JsonConverter<Color?, String?> {
  const MyColorOrNullConverter();

  @override
  Color? fromJson(String? colorStr) {
    if (colorStr == null) return null;
    int value = int.parse(colorStr, radix: 16);
    return Color(value);
  }

  @override
  String? toJson(Color? color) => color?.value.toString();
}
