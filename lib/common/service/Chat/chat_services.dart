import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/user/user_model.dart';
import '../Auth/firebase_database.dart';

class ChatService {
  void newChat(BuildContext context, {required UserModel otherUser}) {
    var currUser = context.uniModel.user;
    var chatId = '${currUser.email}-${otherUser.email}';
    context.router.push(ChatRoute(otherUser: otherUser, chatId: chatId));
  }

  void sendMessage(BuildContext context, String chatId, String content) {
    print('START: sendMessage()');
    var fromId = context.uniModel.user.email;
    var toId = chatId.split('-').firstWhere((item) => item != fromId);
    var createdAt = DateTime.now().toUtc();
    String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(createdAt);
    String docName = '[${fromId?.substring(0, 5)}] '
        '${content.length < 15 ? content : content.substring(0, 15)}'
        ' ${UniqueKey()}';
    // required DateTime createdAt,
    Database().updateFirestore(
        collection: 'chats/$chatId/messages',
        docName: docName,
        toJson: {
          "textContent": content,
          "fromId": fromId,
          "toId": toId,
          "createdAt": createdAtStr,
        });
  }
}
