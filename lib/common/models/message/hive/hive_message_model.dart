import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../convertors.dart';
import '../../user/user_model.dart';
part 'hive_message_model.g.dart';

@HiveType(typeId: 4)
class MessageModelHive {
  @HiveField(0) String? textContent;
  @HiveField(1) String? fromId;
  @HiveField(2) String? toId;
  @HiveField(3) String? createdAt;
  @HiveField(4) @DateTimeStampConv() DateTime? timestamp;
  @HiveField(5) String? messageId;
  @HiveField(6) bool? read;
  MessageModelHive({
    this.textContent,
    this.fromId,
    this.toId,
    this.createdAt,
    this.timestamp,
    this.messageId,
    this.read,
  });

  MessageModelHive toHive(MessageModel message) => MessageModelHive(
    textContent: message.textContent,
    fromId: message.fromId,
    toId: message.toId,
    createdAt: message.createdAt,
    timestamp: message.timestamp,
    messageId: message.messageId,
    read: message.read,
  );

  MessageModel fromHive(MessageModelHive message) => MessageModel(
    textContent: message.textContent,
    fromId: message.fromId,
    toId: message.toId,
    createdAt: message.createdAt,
    timestamp: message.timestamp,
    messageId: message.messageId,
    read: message.read,
  );
}


