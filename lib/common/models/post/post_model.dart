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
    int? likeCounter,
    String? photoCover,
    @MyColorOrNullConverter() Color? colorCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// class ColorOrNullIntConvert implements JsonConverter<Color?, int?> {
//   const ColorOrNullIntConvert();
//
//   @override
//   Color? fromJson(int? json) => json == null ? null : Color(json);
//
//   @override
//   int? toJson(Color? color) => color?.value;
// }

class MyColorOrNullConverter implements JsonConverter<Color?, String?> {
  const MyColorOrNullConverter();

  @override
  Color? fromJson(String? colorStr) {
    if (colorStr == null) return null;
    String valueString =
        colorStr.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  @override
  String? toJson(Color? color) => color.toString();
}

class ColorOrNullConverter implements JsonConverter<String?, Color?> {
  const ColorOrNullConverter();

  @override
  String? fromJson(Color? color) => color.toString();

  @override
  Color? toJson(String? color) {
    if (color == null) return null;
    String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }
}
