// ignore_for_file: invalid_annotation_target
import 'package:example/common/models/message/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../user/user_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@freezed
@HiveType(typeId: 4, adapterName: 'ChatModelAdapter')
class ChatModel with _$ChatModel {
  @JsonSerializable(explicitToJson: true) // This needed for sub classes only
  const factory ChatModel({
    @HiveField(0) String? id, // chat id
    @HiveField(1) MessageModel? lastMessage,
    @HiveField(2) List<String>? usersIds,
    @HiveField(3) List<UserModel>? users,
    @HiveField(4) List<MessageModel>? messages,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
