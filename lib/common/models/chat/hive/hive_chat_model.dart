import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../convertors.dart';
import '../../user/user_model.dart';
part 'hive_chat_model.g.dart';

@HiveType(typeId: 5)
class ChatModelHive {
  @HiveField(0) String? id; // chat id
  @HiveField(1) MessageModel? lastMessage;
  @HiveField(2) List<String>? usersIds;
  @HiveField(3) List<UserModel>? users;
  @HiveField(4) List<MessageModel>? messages;
  ChatModelHive({
    this.id,
    this.lastMessage,
    this.usersIds,
    this.users,
    this.messages,
  });

  static ChatModel toHive(ChatModel message) => ChatModel(
    id: message.id,
    lastMessage: message.lastMessage,
    usersIds: message.usersIds,
    users: message.users,
    messages: message.messages,
  );

  static ChatModel fromHive(ChatModelHive message) => ChatModel(
    id: message.id,
    lastMessage: message.lastMessage,
    usersIds: message.usersIds,
    users: message.users,
    messages: message.messages,
  );
}


