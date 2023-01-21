import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../screens/chat_ui/chat_screen.dart' as screen;
import '../../models/post/post_model.dart';
import '../../models/user/user_model.dart';
import '../Database/firebase_db.dart';
import '../Database/firebase_db.dart' as click;

// ChatService Usage At [screen.ChatScreen] // <<---
// streamMessages() Available At [click.Database] // <<---

class ChatService {
  static Future openChat(BuildContext context,
      {required UserModel otherUser, PostModel? postReply}) async {
    print('START: openChat()');
    var currUser = context.uniProvider.currUser;

    String? chatId;
    var userIds = [currUser.uid, otherUser.uid];
    var reqBase = Database.db.collection('chats').limit(1);

    var snap = await reqBase.where('usersIds', isEqualTo: userIds).get();
    if (snap.docs.isEmpty) {
      // Check the reversed option.
      snap = await reqBase.where('usersIds', isEqualTo: userIds.reversed.toList()).get();
    }

    if (snap.docs.isEmpty) {
      // (Still empty..)
      chatId = '${currUser.email}-${otherUser.email}';
    } else {
      chatId = snap.docs.first.id;
    }
    print('chatId ${chatId}');
    return context.router
        .push(ChatRoute(otherUser: otherUser, chatId: chatId, postReply: postReply));
  }

  static void chatWithUs(BuildContext context) {
    ChatService.openChat(context,
        otherUser: UserModel(
            uid: 'IVGr0VcKbhOg5jK23r9DTzvGhar2',
            age: 20,
            name: 'Riltopia Team',
            gender: GenderTypes.other,
            photoUrl:
                'https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/The%20Biton_Profile_2023-01-21%2023%3A05%3A48.369962?alt=media&token=62ab2f84-8d74-4b7f-8e79-5f1a0bee85fc',
            email: 'idanbit80@gmail.com',
            bio: 'Tell us what u think!',
            isOnline: true,
            tags: ['Tech'],
            birthday: DateTime.fromMillisecondsSinceEpoch(1041552000) // 03.01.03
            ));
  }

  void sendMessage(
    BuildContext context, {
    required String chatId,
    required String content,
    required UserModel otherUser,
    PostModel? postReply,
  }) {
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
      id: messageId,
      textContent: content,
      fromId: fromId!,
      toId: toId!,
      createdAt: createdAtStr,
      timestamp: timeStamp,
      postReply: postReply,
    );

    var chatData = ChatModel(
      id: chatId,
      timestamp: timeStamp,
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
