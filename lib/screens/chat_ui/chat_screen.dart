import 'package:auto_route/auto_route.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../common/models/message/message_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Database/firebase_database.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/postBlock_sts.dart';
import '../feed_ui/create_post_screen.dart';
import '../feed_ui/user_screen.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;
  final PostModel? postReply;
  final String chatId;

  ChatScreen({required this.otherUser, required this.chatId, this.postReply, Key? key})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messagesController = ScrollController();
  var sendController = TextEditingController();
  List<MessageModel> messages = [];
  Timestamp? timeStamp;
  bool isInitMessages = true;

  // var splashLoader = true;
  // List<MessageModel> chatList = [];
  //

  // @override
  // void initState() {
  //   _loadOlderMessages().then((_) => messages.remove(messages.first));
  //   super.initState();
  // }

  Future _loadOlderMessages() async {
    // splashLoader = true; setState(() {});
    List olderMessages = await Database.advanced.handleGetModel(ModelTypes.messages, messages,
        collectionReference: 'chats/${widget.chatId}/messages');
    if (olderMessages.isNotEmpty) messages = [...olderMessages];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('chatId ${widget.chatId}');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: darkAppBar(context,
            // title: widget.otherUser.name.toString(),
            title: null,
            // centerTitle: true,
            titleWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            widget.otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder)),
                    buildOnlineBadge(ratio: 1.0)
                  ],
                ),
                10.horizontalSpace,
                Text(
                  widget.otherUser.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.text18PxSemiBold.white,
                ),
              ],
            )),
        body: Column(
          children: [
            StreamProvider<List<MessageModel>>.value(
              value: Database.streamMessages(widget.chatId, limit: isInitMessages ? 25 : 1),
              initialData: const [],
              builder: (context, child) {
                print('START: builder()');
                var newMsgs = context.listenMessagesModelList;
                if (newMsgs.isNotEmpty) {
                  messages.isEmpty ? setInitMessages(newMsgs) : addLatestMessage(context);
                }

                return LazyLoadScrollView(
                  scrollOffset: 300,
                  onEndOfPage: () async {
                    print('START: onEndOfPage()');

                    if (messages.isNotEmpty) {
                      timeStamp = Timestamp.fromDate(messages.last.timestamp!);
                    }
                    // context.uniProvider.updateIsFeedLoading(true);
                    await _loadOlderMessages();
                    // context.uniProvider.updateIsFeedLoading(false);
                  },
                  child: ListView.builder(
                    controller: messagesController,
                    reverse: true,
                    // controller: ,
                    itemCount: messages.length,
                    itemBuilder: (context, i) =>
                        buildBubble(context, messages[i], (i + 1) == messages.length),
                  ),
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

  void setInitMessages(List<MessageModel> newMsgs) {
    print('START: setInitMessages()');
    messages = newMsgs;
    isInitMessages = false;
    // _loadOlderMessages();
  }

  void addLatestMessage(BuildContext context) {
    print('START: addLatestMessage()');
    var newMessage = context.listenMessagesModelList.first;
    if (!(messages.contains(newMessage))) {
      messages.insert(0, newMessage);
      messagesController.jumpTo(0);
    }
  }


  Widget buildTextField(BuildContext context, String chatId, UserModel otherUser) {
    bool includeHeb = sendController.text.isHebrew;
    var post = widget.postReply;
    return StatefulBuilder(builder: (context, stfSetState) {
      return Column(
        children: [
          if (post != null)
            buildReplyContainer(post!, onTap: () {
              post = null;
              stfSetState(() {});
            }),
          3.verticalSpace,
          TextField(
            // onTapOutside: (event) => setState(() => sendNode.unfocus()),
            autofocus: post != null,
            controller: sendController,
            style: AppStyles.text16PxRegular.white,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            textAlign: includeHeb ? TextAlign.end : TextAlign.start,
            cursorColor: AppColors.primaryOriginal,
            onChanged: (val) => stfSetState(() {}),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.darkOutline50,
              hintStyle: AppStyles.text14PxRegular.greyLight,
              focusedBorder: InputBorder.none,
              hintText: 'Write your message...',
              suffixIcon: buildSendButton(
                isActive: sendController.text.isNotEmpty,
                onTap: () {
                  ChatService().sendMessage(context,
                      chatId: chatId, content: sendController.text, otherUser: otherUser);
                  sendController.clear();
                },
              ),
            ),
          )
              .roundedOnly(
            bottomLeft: 10,
            topLeft: post != null ? 3 : 10,
            topRight: post != null ? 3 : 10,
            bottomRight: 10,
          )
              .pOnly(bottom: 6),
        ],
      ).px(8);
    });
  }

  Widget buildReplyContainer(PostModel post, {GestureTapCallback? onTap}) {
    return Builder(builder: (context) {
      var postDiff = DateTime.now().difference(post.timestamp!);
      var postAgo = postDiff.inSeconds < 60
          ? '${postDiff.inSeconds} sec ago'
          : '${postDiff.inMinutes} min ago';
      if (postDiff.inSeconds == 0) postAgo = 'Just now';
      return Container(
          color: AppColors.darkOutline50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              5.verticalSpace,
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
                        backgroundColor: AppColors.darkOutline,
                      ),
                      buildOnlineBadge(),
                    ],
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      '${post.creatorUser?.name}'
                          .toText(fontSize: 14, bold: true, color: AppColors.white),
                      postAgo
                          .toText(color: AppColors.grey50, fontSize: 11)
                          .pOnly(right: 10, top: 0, bottom: 0),
                    ],
                  ),
                  // TODO ADD ON POST MVP ONLY (ago · Tag (Add Tags))
                  const Spacer(),
                  // .onTap(() {}, radius: 10), // TODO Add move to Tag
                  // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
                  Assets.svg.close.svg(height: 17, color: AppColors.grey50).pad(13).onTap(
                      onTap, radius: 10),
                  // 10.horizontalSpace,
                ],
              ),
              4.verticalSpace,
              buildExpandableText(
                // 'Example : let’s try to think of an topic or fdsk conte tou fc words as possible... I think I’ve already ',
                  post.textContent,
                  maxLines: 4,
                  textAlign: post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
                  textDirection:
                  post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                  style: AppStyles.text14PxRegular.copyWith(color: AppColors.grey50))
                  .advancedSizedBox(context, maxWidth: true)
                  .pOnly(left: 50, bottom: 5, right: 45)
            ],
          )).roundedOnly(
        bottomLeft: 3,
        topLeft: 10,
        topRight: 10,
        bottomRight: 3,
      );
    });
  }

  Widget buildBubble(BuildContext context, MessageModel message, bool isLastMessage) {
    // print('START: buildBubble()');

    bool currUser = message.fromId == context.uniProvider.currUser.uid;
    bool isHebrew = message.textContent!.isHebrew;
    return Row(
      mainAxisAlignment: currUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width * 0.8),
            child: Container(
              // elevation: 0,
                padding: const EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 6),
                margin: 5.horizontal,
                decoration: BoxDecoration(
                    color: currUser ? AppColors.primaryLight : AppColors.darkOutline50,
                    borderRadius: BorderRadius.only(
                      bottomRight: 10.circular,
                      topRight: (currUser ? 3 : 10).circular,
                      topLeft: (currUser ? 10 : 3).circular,
                      bottomLeft: 10.circular,
                    )),
                // padding: const BubbleEdges.all(8.0),
                // nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                // nipRadius: 0,
                // showNip: false,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.textContent!,
                        textAlign: isHebrew ? TextAlign.end : TextAlign.start,
                        style: AppStyles.text16PxRegular.white),
                    5.verticalSpace,
                    Text(message.createdAt!.substring(9, 14),
                        style: AppStyles.text10PxRegular.copyWith(color: AppColors.greyLight))
                  ],
                ))).px(6).py(4)
      ],
    );
  }
}
