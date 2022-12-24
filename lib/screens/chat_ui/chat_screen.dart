import 'package:auto_route/auto_route.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/models/message/message_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Database/firebase_database.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../widgets/app_bar.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;
  final String chatId;

  ChatScreen({required this.otherUser, required this.chatId, Key? key})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var sendController = TextEditingController();
  // var splashLoader = true;
  // List<MessageModel> chatList = [];
  //
  // @override
  // void initState() {
  //   _loadMore();
  //   super.initState();
  // }
  //
  // Future _loadMore() async {
  //   // splashLoader = true; setState(() {});
  //   chatList = await Database.advanced.handleGetDocs(context, ModelTypes.messages, latest: true) ?? [];
  //   // chatList = await Database.getChats(context.uniProvider.currUser.uid!) ?? [];
  //   splashLoader = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    print('chatId ${widget.chatId}');
    print('context.routeData.path ${context.routeData.path}');
    // print('context.routeData.path ${context.routeData.queryParams}');
    // print('context.routeData.path ${context.routeData.name}');
    // print('context.routeData.path ${context.routeData.meta}');
    String myurl = Uri.base.toString(); //get complete url
    print('myurl ${myurl}');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        appBar: darkAppBar(context, title: widget.otherUser.email.toString()),
        body: Column(
          children: [
            StreamProvider<List<MessageModel>>.value(
              value: Database.streamMessages(widget.chatId),
              initialData: const [],
              builder: (context, child) {
                var messages = context.listenMessagesModelList;
                print('messages.length ${messages.length}');
                // print('messages ${messages.length}');

                // WriteBatch messagesBatch = Database.db.batch();
                // for (var message in messages) {
                //   if (message.toId == context.uniProvider.currUser.uid) {
                //     // Todo make sure this works!
                //     ChatService()
                //         .setMessageRead(message, widget.chatId, messagesBatch);
                //   }
                // }
                // messagesBatch.commit();

                return ListView.builder(
                  reverse: true,
                  // controller: ,
                  itemCount: messages.length,
                  itemBuilder: (context, i) => buildBubble(
                      context, messages[i], (i + 1) == messages.length),
                );
              },
            ).expanded(),
            4.verticalSpace,
            buildTextField(context, widget.chatId, widget.otherUser)
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      BuildContext context, String chatId, UserModel otherUser) {
    return StatefulBuilder(builder: (context, stfSetState) {
      bool includeHeb = sendController.text.isHebrew;
      return TextField(
        // onTapOutside: (event) => setState(() => sendNode.unfocus()),
        controller: sendController,
        style: AppStyles.text14PxRegular.white,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        textAlign: includeHeb ? TextAlign.end : TextAlign.start,
        cursorColor: AppColors.primaryOriginal,
        onChanged: (val) => stfSetState(() {}),
        decoration: InputDecoration(
          hintStyle: AppStyles.text18PxRegular.white,
          filled: true,
          fillColor: AppColors.darkGrey,
          hintText: '',
          focusedBorder: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: sendController.text.isNotEmpty
                  ? AppColors.white
                  : AppColors.darkGrey,
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  size: 25,
                  color: sendController.text.isNotEmpty
                      ? AppColors.primaryOriginal
                      : AppColors.primaryOriginal,
                ),
                onPressed: sendController.text.isNotEmpty
                    ? () {
                        ChatService().sendMessage(context,
                            chatId: chatId,
                            content: sendController.text,
                            otherUser: otherUser);
                        sendController.clear();
                      }
                    : null,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildBubble(
      BuildContext context, MessageModel message, bool isLastMessage) {
    print('START: buildBubble()');

    bool currUser = message.fromId == context.uniProvider.currUser.uid;
    bool isHebrew = message.textContent!.isHebrew;
    return Row(
      mainAxisAlignment:
          currUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width * 0.8),
            child: Bubble(
                color: currUser ? AppColors.primaryOriginal : AppColors.darkGrey,
                elevation: 0,
                padding: const BubbleEdges.all(6.0),
                nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(message.textContent!,
                        textAlign: isHebrew ? TextAlign.end : TextAlign.start,
                        style: AppStyles.text16PxRegular.white),
                    Text(message.createdAt!.substring(9, 14),
                        style: AppStyles.text12PxRegular.greyLight)
                  ],
                ))).px(6).py(6)
      ],
    );
  }
}
