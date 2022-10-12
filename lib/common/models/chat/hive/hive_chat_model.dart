import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/hive/hive_message_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../convertors.dart';
import '../../user/hive/hive_user_model.dart';
import '../../user/user_model.dart';
part 'hive_chat_model.g.dart';

@HiveType(typeId: 5)
class ChatModelHive {
  @HiveField(0) String? id; // chat id
  @HiveField(1) MessageModelHive? lastMessage;
  @HiveField(2) List<String>? usersIds;
  @HiveField(3) List<UserModelHive>? users;
  @HiveField(4) List<MessageModelHive>? messages;
  @HiveField(5) @DateTimeStampConv() DateTime? timestamp;
  ChatModelHive({
    this.id,
    this.lastMessage,
    this.usersIds,
    this.users,
    this.messages,
    this.timestamp,
  });

  static ChatModelHive toHive(ChatModel chat) {
    var lastMessage = MessageModelHive.toHive(chat.lastMessage!);
    var messages = chat.messages?.map((model)
          => MessageModelHive.toHive(model)).toList() ?? [];
    var users = chat.users?.map((model)
          => UserModelHive.toHive(model)).toList() ?? [];

    return ChatModelHive(
      id: chat.id,
      lastMessage: lastMessage,
      usersIds: chat.usersIds,
      users: users,
      messages: messages,
      timestamp: chat.timestamp,
    );
  }

  static ChatModel fromHive(ChatModelHive chat) {
    var lastMessage = MessageModelHive.fromHive(chat.lastMessage!);
    var messages = chat.messages?.map((model)
          => MessageModelHive.fromHive(model)).toList() ?? [];
    var users = chat.users?.map((model)
         => UserModelHive.fromHive(model)).toList() ?? [];

    return ChatModel(
      id: chat.id,
      lastMessage: lastMessage,
      usersIds: chat.usersIds,
      users: users,
      messages: messages,
      timestamp: chat.timestamp,
    );
  }
}


