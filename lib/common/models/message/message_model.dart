// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';


// flutter pub run build_runner build --delete-conflicting-outputs
//~ Don't forget to manually add in HIVE Model!
@freezed
class MessageModel with _$MessageModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory MessageModel({
    String? id, // Cuz new field, was not exist at begging
    String? textContent,
    String? fromId,
    String? toId,
    String? createdAt,
    PostModel? postReply,
    @Default(false) bool isRead,
    @Default({}) Map<String, dynamic> metadata,
    @Default(false) bool? isPostComment,
    @DateTimeStampConv() DateTime? timestamp,
    bool? read,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
