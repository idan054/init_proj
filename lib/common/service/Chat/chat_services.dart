import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../screens/chat_ui/chat_screen.dart' as screen;
import '../../models/user/user_model.dart';
import '../Auth/firebase_database.dart';
import '../Auth/firebase_database.dart' as click;

/// ChatService Usage At [screen.ChatScreen] // <<---
/// streamMessages() Available At [click.Database] // <<---

class ChatService {
  //> This do nothing on Firestore.
  void openChat(BuildContext context,
      {required UserModel otherUser, String? chatId}) {
    if (chatId == null) {
      var currUser = context.uniProvider.currUser;
      chatId = '${currUser.email}-${otherUser.email}';
    }
    context.router.push(ChatRoute(otherUser: otherUser, chatId: chatId));
  }

  void setMessageRead(MessageModel message, String chatId, WriteBatch batch) {
    // Todo make sure it works!
    print('chatId ${chatId}');
    print('message ${message.messageId}');
    Database().addToBatch(
        batch: batch,
        collection: 'chats/$chatId/messages',
        docName: message.messageId,
        toJson: {'read': true});
  }

  void sendMessage(BuildContext context,
      {required String chatId,
      required String content,
      required UserModel otherUser}) {
    print('START: sendMessage()');

    var fromId = context.uniProvider.currUser.uid;
    var toId = otherUser.uid;
    var timeStamp = DateTime.now();
    String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);
    // var messageIdA = const Uuid().v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
    // docName result example: [idanb] מה קורה [#b4918]
    String messageId = '[${fromId?.substring(0, 5)}] '
        '${content.length < 15 ? content : content.substring(0, 15)}'
        ' ${UniqueKey()}';

    var messageData = MessageModel(
      textContent: content,
      fromId: fromId!,
      toId: toId!,
      messageId: messageId,
      createdAt: createdAtStr,
      timestamp: timeStamp,
    );

    var chatData = ChatModel(
      id: chatId,
      lastMessage: messageData,
      users: [context.uniProvider.currUser, otherUser],
      usersIds: [context.uniProvider.currUser.uid!, otherUser.uid!],
    );

    // Start a Batch requests.
    var sendMessageBatch = Database.db.batch();

    Database().addToBatch(
      batch: sendMessageBatch,
      collection: 'chats',
      docName: chatId,
      toJson: chatData.toJson(),
    );

    Database().addToBatch(
        batch: sendMessageBatch,
        collection: 'chats/$chatId/messages',
        docName: messageId,
        toJson: messageData.toJson());

    sendMessageBatch.commit();
  }
}
