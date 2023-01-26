import 'package:auto_route/auto_route.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../common/models/message/message_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/postBlock_sts.dart';
import '../feed_ui/create_post_screen.dart';
import '../user_ui/user_screen.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;
  final ChatModel? chat;
  final PostModel? postReply;
  final String chatId;

  const ChatScreen({required this.otherUser, required this.chatId, this.postReply, this.chat, Key? key})
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
  PostModel? post;

  // var splashLoader = true;
  // List<MessageModel> chatList = [];
  //

  @override
  void initState() {
    post = widget.postReply;
    // _loadOlderMessages().then((_) => messages.remove(messages.first));
    super.initState();
  }

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
            ).pOnly(right: 10).onTap(() {
              context.router.push(UserRoute(user: widget.otherUser));
            })),
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
            StatefulBuilder(builder: (context, stfState) {
              return buildTextField(context,
                  stfSetState: stfState,
                  post: post,
                  hintText: 'Write your message...',
                  postOnCloseReply: () {
                    post = null;
                    stfState(() {});
                  },
                  controller: sendController,
                  onTap: () {
                    ChatService().sendMessage(
                      context,
                      chatId: widget.chatId,
                      content: sendController.text,
                      otherUser: widget.otherUser,
                      postReply: post,
                    );
                    sendController.clear();
                    post = null;
                    stfState(() {});
                  });
            }),
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

  Widget buildBubble(BuildContext context, MessageModel message, bool isLastMessage) {
    // print('START: buildBubble()');

    bool currUser = message.fromId == context.uniProvider.currUser.uid;
    bool isHebrew = message.textContent!.isHebrew;

    return Row(
      mainAxisAlignment: currUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            if (message.postReply != null)
              buildReplyBubble(context, currUser, message).px(6).pOnly(top: 4),
            ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: context.width * 0.8),
                    // child: Bubble(
                    child: Container(
                        // elevation: 0,
                        padding: const EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 6),
                        margin: 5.horizontal,
                        decoration: BoxDecoration(
                            color: currUser ? AppColors.primaryLight : AppColors.darkOutline50,
                            borderRadius: BorderRadius.only(
                              bottomRight: 10.circular,
                              topRight: message.postReply != null
                                  ? 3.circular
                                  : (currUser ? 3 : 10).circular,
                              topLeft: message.postReply != null
                                  ? 3.circular
                                  : (currUser ? 10 : 3).circular,
                              bottomLeft: 10.circular,
                            )),
                        // padding: const BubbleEdges.all(8.0),
                        // nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                        // nipRadius: 0,
                        // showNip: false,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message.postReply != null) Row(), // AKA Expanded
                            Text(message.textContent!,
                                textAlign: isHebrew ? TextAlign.end : TextAlign.start,
                                textDirection: isHebrew ? TextDirection.rtl : TextDirection.ltr,
                                style: AppStyles.text16PxRegular.white),
                            5.verticalSpace,
                            Text(message.createdAt!.substring(9, 14),
                                style:
                                    AppStyles.text10PxRegular.copyWith(color: AppColors.greyLight))
                          ],
                        ))).px(6).pOnly(
                  bottom: 4,
                  top: message.postReply != null ? 2.5 : 4,
                ),
          ],
        )
      ],
    );
  }

  ConstrainedBox buildReplyBubble(BuildContext context, bool currUser, MessageModel message) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.width * 0.8),
        // child: Bubble(
        child: Container(
            // elevation: 0,
            padding: const EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 6),
            margin: 5.horizontal,
            decoration: BoxDecoration(
                color: currUser ? AppColors.primaryLight : AppColors.darkOutline50,
                borderRadius: BorderRadius.only(
                  bottomRight: 3.circular,
                  topRight: (currUser ? 3 : 10).circular,
                  topLeft: (currUser ? 10 : 3).circular,
                  bottomLeft: 3.circular,
                )),
            // padding: const BubbleEdges.all(8.0),
            // nip: currUser ? BubbleNip.rightTop : BubbleNip.leftTop,
            // nipRadius: 0,
            // showNip: false,
            child: buildReplyProfile(
              context,
              message.postReply!,
              actionButton: 'View Ril'.toText(medium: true).pad(13).onTap(() {
                // TODO LATER LIST: Add View Ril Reply OnTap
              }, radius: 10),
            )));
  }
}

Widget buildReplyField(PostModel post, {GestureTapCallback? onTap}) {
  return Builder(builder: (context) {
    return Container(
            color: AppColors.darkOutline50,
            // color: AppColors.primaryLight,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: buildReplyProfile(context, post,
                actionButton: Icons.close_rounded
                    .icon(size: 22, color: AppColors.grey50)
                    // Assets.svg.close.svg(height: 17, color: AppColors.grey50)
                    .pad(13)
                    .onTap(onTap, radius: 10)))
        .roundedOnly(
      bottomLeft: 3,
      topLeft: 10,
      topRight: 10,
      bottomRight: 3,
    );
  });
}

Widget buildTextField(
  BuildContext context, {
  required TextEditingController controller,
  required StateSetter stfSetState,
  GestureTapCallback? onTap,
  PostModel? post,
  GestureTapCallback? postOnCloseReply,
  String? hintText,
}) {
  bool includeHeb = controller.text.isHebrew;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (post != null) buildReplyField(post, onTap: postOnCloseReply),
      3.verticalSpace,
      TextField(
        // onTapOutside: (event) => setState(() => sendNode.unfocus()),
        autofocus: post != null,
        controller: controller,
        style: AppStyles.text16PxRegular.white,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        textAlign: controller.text.isEmpty
            ? TextAlign.start
            : includeHeb
                ? TextAlign.end
                : TextAlign.start,
        cursorColor: AppColors.white,
        onChanged: (val) => stfSetState(() {}),
        decoration: InputDecoration(
            filled: true,
            // fillColor: AppColors.primaryLight,
            fillColor: AppColors.darkOutline50,
            hintStyle: AppStyles.text14PxRegular.greyLight,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            suffixIcon: buildSendButton(isActive: controller.text.isNotEmpty, onTap: onTap)),
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
}

Column buildReplyProfile(BuildContext context, PostModel post, {Widget? actionButton}) {
  var name = '${post.creatorUser?.name}';
  var shortName = name.length > 13 ? name.substring(0, 13) + '...'.toString() : name;
  var postAgo = postTime(post.timestamp!);
  return Column(
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
              // buildOnlineBadge(),
            ],
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              shortName.toText(fontSize: 14, bold: true, color: AppColors.white, softWrap: false),
              postAgo
                  .toText(color: AppColors.grey50, fontSize: 11)
                  .pOnly(right: 10, top: 0, bottom: 0),
            ],
          ),
          // TODO ADD ON POST MVP ONLY (ago · Tag (Add Tags))
          const Spacer(),
          // .onTap(() {}, radius: 10), // TODO Add move to Tag
          // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
          actionButton ?? const Offstage()
          // 10.horizontalSpace,
        ],
      ),
      4.verticalSpace,
      buildExpandableText(
              // 'Example : let’s try to think of an topic or fdsk conte tou fc words as possible... I think I’ve already ',
              post.textContent,
              maxLines: 4,
              textAlign: post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
              textDirection: post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
              style: AppStyles.text14PxRegular.copyWith(color: AppColors.grey50))
          .advancedSizedBox(context, maxWidth: true)
          .pOnly(left: 50, bottom: 5, right: 45)
    ],
  );
}
