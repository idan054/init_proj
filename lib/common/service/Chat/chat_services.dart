import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Hive/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../screens/chat_ui/chat_screen.dart' as screen;
import '../../models/message/hive/hive_message_model.dart';
import '../../models/user/user_model.dart';
import '../Database/firebase_database.dart';
import '../Database/firebase_database.dart' as click;

// ChatService Usage At [screen.ChatScreen] // <<---
// streamMessages() Available At [click.Database] // <<---

class ChatService {

  static Future openChat(BuildContext context, {required UserModel otherUser}) async {
    print('START: openChat()');
    var currUser = context.uniProvider.currUser;

    /// Hive saves always needed request when open chat!
    //> Exist in Hive cache?
    // ChatId: idanbit80@gmail.com-theblackhero2@gmail.com
    List cachedChatsIdsList = HiveServices.uniBox.get('ChatsIdsList') ?? [];
    String? chatIdHive = cachedChatsIdsList
        .firstWhere((chatIdStr) => chatIdStr
        ?.contains(otherUser.email!) ?? false, orElse: () => null);
    print('HIVE chatId: $chatIdHive');

    //> Not in Hive cache? Check Firestore:
    String? chatId;
    if (chatIdHive == null) {
      // Not in Hive cache - search in Firestore.
      var snap = await Database.db
          .collection('chats')
          .where('usersIds', whereIn: [[currUser.uid], [otherUser.uid]])
          .get();
      chatId = snap.docs.isEmpty ? null : snap.docs.first.data()['id'];

      //> Exist in Firestore! - Add to cache.
      if (chatId != null) {
        print('DATABASE chatId: $chatId');
      } else {
      //> Not exist (New)
        print('NO chatId found. (Create new chat)');
        chatId = '${currUser.email}-${otherUser.email}';
      }
    }
    HiveServices.uniBox.put('ChatsIdsList', [...cachedChatsIdsList, chatId]);
    return context.router.push(ChatRoute(otherUser: otherUser, chatId: chatIdHive ?? chatId!));
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
      {required String chatId, required String content, required UserModel otherUser}) {
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
      timestamp: timeStamp,
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
