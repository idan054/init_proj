// ignore_for_file: invalid_annotation_target
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../convertors.dart';
import '../user/user_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
//~ Don't forget to manually add in HIVE Model!
class ChatModel with _$ChatModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory ChatModel({
    String? id, // chat id
    MessageModel? lastMessage,
    List<String>? usersIds,
    List<UserModel>? users,
    List<MessageModel>? messages,
    @DateTimeStampConv() DateTime? timestamp,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
