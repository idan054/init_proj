import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/models.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/models/message/message_model.dart';
import '../../common/service/Auth/firebase_database.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../widgets/app_bar.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;
  final String chatId;

  const ChatScreen({required this.otherUser, required this.chatId, Key? key})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var sendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var otherUser = widget.otherUser;
    var chatId = widget.chatId;
    print('chatId ${chatId}');

    return Scaffold(
      appBar: classicAppBar(context, title: otherUser.email.toString()),
      body: Column(
        children: [
          StreamProvider<List<MessageModel>>.value(
            value: Database.streamMessages(chatId),
            initialData: const [],
            builder: (context, child) {
              var messages = context.listenMessagesModelList;
              // print('messages ${messages.length}');

              WriteBatch messagesBatch = Database.db.batch();
              for (var message in messages) {
                if (message.toId == context.uniProvider.currUser.uid) {
                  // Todo make sure this works!
                  ChatService()
                      .setMessageRead(message, widget.chatId, messagesBatch);
                }
              }
              messagesBatch.commit();

              return Scaffold(
                backgroundColor: Colors.grey[100]!,
                body: ListView.builder(
                  reverse: true,
                  // controller: ,
                  itemCount: messages.length,
                  itemBuilder: (context, i) =>
                      buildBubble(messages[i], (i + 1) == messages.length),
                ),
              );
            },
          ).expanded(),
          buildTextField(context, chatId, otherUser).rtl
        ],
      ),
    );
  }

  TextField buildTextField(
      BuildContext context, String chatId, UserModel otherUser) {
    return TextField(
      controller: sendController,
      style: AppStyles.text14PxRegular.white,
      decoration: InputDecoration(
        hintStyle: AppStyles.text14PxRegular.white,
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'Type your message...',
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            ChatService().sendMessage(context,
                chatId: chatId,
                content: sendController.text,
                otherUser: otherUser);
            sendController.clear();
          },
        ),
      ),
    );
  }

  Widget buildBubble(MessageModel message, bool isLastMessage) {
    print('START: buildBubble()');

    bool currUser = message.fromId == context.uniProvider.currUser.uid;
    return Row(
      mainAxisAlignment:
          currUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width * 0.8),
            child: Bubble(
                    color: Colors.blueGrey,
                    elevation: 0,
                    padding: const BubbleEdges.all(10.0),
                    nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                    child: Text(message.textContent,
                        style: AppStyles.text16PxRegular.white))
                .pad(6))
      ],
    );
  }
}
