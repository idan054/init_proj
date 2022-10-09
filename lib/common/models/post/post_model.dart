// ignore_for_file: invalid_annotation_target
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    @ColorIntConv() Color? colorCover,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

class DateTimeStampConv implements JsonConverter<DateTime, Timestamp> {
  const DateTimeStampConv();

  @override // return DateTime from Timestamp
  DateTime fromJson(Timestamp json) => json.toDate();

  @override // return Timestamp from DateTime
  Timestamp toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

class ColorIntConv implements JsonConverter<Color, String> {
  const ColorIntConv();

  @override // return color from String
  Color fromJson(String json) {
    return Color(int.parse(json));
  }

  @override // return String from color
  String toJson(Color color) {
    var colorX = '0x${'$color'.split('0x')[1]}'.replaceAll(')', '');
    return colorX;
  }
}
