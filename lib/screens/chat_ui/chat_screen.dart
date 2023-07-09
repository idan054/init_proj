import 'package:auto_route/auto_route.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import '../../widgets/components/postBlock_stf.dart';
import '../feed_ui/create_post_screen.dart';
import '../user_ui/user_screen.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;
  final ChatModel? chat;
  final PostModel? postReply;
  final String chatId;

  const ChatScreen(
      {required this.otherUser, required this.chatId, this.postReply, this.chat, Key? key})
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
  bool isLoadOlderMessages = false;
  PostModel? post;

  Color otherUserBubble = AppColors.darkGrey;
  Color currUserBubble = AppColors.primaryOriginal;
  Color textFieldBg = AppColors.darkGrey;

  // var splashLoader = true;
  // List<MessageModel> chatList = [];
  //

  @override
  void initState() {
    post = widget.postReply;
    _loadOlderMessages().then((_) => messages.remove(messages.first));
    super.initState();
  }

  Future _loadOlderMessages() async {
    // splashLoader = true; setState(() {});
    List withOlderMessages = await Database.advanced.handleGetModel(
        context, ModelTypes.messages, messages,
        collectionReference: 'chats/${widget.chatId}/messages');
    if (withOlderMessages.isNotEmpty) messages = [...withOlderMessages];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('chatId ${widget.chatId}');

    return WillPopScope(
      onWillPop: () async {
        print('START: onWillPop()');
        ChatService.resetChatUnread(context, widget.chatId);
        context.uniProvider.activeChatUpdate(widget.chat?.copyWith(
          messages: messages,
          lastMessage: messages.last,
          unreadCounter: 0,
        ));
        Navigator.pop(context);
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.primaryDark,
          appBar: buildDarkAppBar(context),
          body: Column(
            children: [
              const Divider(thickness: 2, color: AppColors.darkGrey, height: 2),

              // StreamProvider<List<MessageModel>>.value(
              NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  // final ScrollDirection direction = notification.direction;
                  // if (direction == ScrollDirection.reverse) {
                  //   isLoadOlderMessages = true;
                  // } else if (direction == ScrollDirection.forward) {
                  //   isLoadOlderMessages = false;
                  // }
                  // // setState(() {});
                  return true;
                },
                child: StreamBuilder<List<MessageModel>>(
                  stream: Database.streamMessages(widget.chatId, limit: 1),
                  // initialData: [],
                  // limit: isInitMessages ? 25 : 1),
                  builder: (context, snapshot) {
                    print('START: builder()');
                    // var newMsgs = context.listenMessagesModelList;

                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      MessageModel? newMsg = snapshot.data?.first;
                      _addLatestMessage(newMsg);
                    }

                    return LazyLoadScrollView(
                      scrollOffset: 300,
                      onEndOfPage: () async {
                        print('START: CHAT onEndOfPage()');

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
                        itemBuilder: (context, i) => buildBubble(context, messages[i]),
                      ),
                    );
                  },
                ).expanded(),
              ),
              4.verticalSpace,
              StatefulBuilder(builder: (context, stfState) {
                return buildTextField(context, textFieldBg,
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
      ),
    );
  }

  AppBar buildDarkAppBar(BuildContext context) {
    return darkAppBar(context,
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
                    backgroundImage:
                        NetworkImage(widget.otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder)),
                buildOnlineBadge(context, widget.otherUser, ratio: 1.0)
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
          // Users cant go RilTopia Team Profile because this is hack for when user is blocked
          // (He can only "Chat with us" & From there go to Conversions & More...
          if (widget.otherUser.email == 'idanbit80@gmail.com') return;

          context.router.push(UserRoute(user: widget.otherUser));
        }));
  }

  // void addMessages(List<MessageModel> newMsgs) {
  //   print('START: addMessages()');
  //   messages = [...newMsgs, ...messages];
  //   isInitMessages = false;
  // }

  // Future<List<MessageModel>> _setInitMessages(List<MessageModel> newMsgs) {
  //   print('START: setInitMessages()');
  //   messages = newMsgs;
  //   isInitMessages = false;
  //   // _loadOlderMessages();
  // }

  void _addLatestMessage(MessageModel? newMessage) {
    print('START: _addLatestMessage()');
    // var newMessage = context.listenMessagesModelList.first;
    if (newMessage != null && !(messages.contains(newMessage))) {
      messages.insert(0, newMessage);
      messagesController.jumpTo(0);
    }
  }

  Widget buildBubble(BuildContext context, MessageModel message) {
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
                            color: currUser ? currUserBubble : otherUserBubble,
                            borderRadius: BorderRadius.only(
                              bottomRight: 15.circular,
                              topRight: message.postReply != null
                                  ? 3.circular
                                  : (currUser ? 3 : 15).circular,
                              topLeft: message.postReply != null
                                  ? 3.circular
                                  : (currUser ? 15 : 3).circular,
                              bottomLeft: 15.circular,
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
                                textAlign: isHebrew ? TextAlign.right : TextAlign.left,
                                textDirection: isHebrew ? TextDirection.rtl : TextDirection.ltr,
                                style: AppStyles.text16PxRegular.copyWith(
                                  color: currUser ? AppColors.darkBg : AppColors.white,
                                )),
                            5.verticalSpace,
                            Builder(builder: (context) {
                              // AKA if today, show time only, no date.
                              var time = (message.timestamp!.day == DateTime.now().day &&
                                      message.timestamp!.month == DateTime.now().month &&
                                      message.timestamp!.year == DateTime.now().year)
                                  ? message.createdAt!.substring(9, 14)
                                  : message.createdAt!.substring(0, 14);

                              return Text(time,
                                  style: AppStyles.text10PxRegular.copyWith(
                                      color: currUser
                                          ? AppColors.darkGrey
                                          : AppColors.greyLight));
                            })
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
                color: currUser ? currUserBubble : otherUserBubble,
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
              currUser,
              message.postReply!,
              // actionButton: 'View Ril'.toText(medium: true).pad(13).onTap(() {
              //   TODO LATER LIST: Add View Ril Reply OnTap
              // }, radius: 10),
            )));
  }
}

Widget buildReplyField(PostModel post, Color textFieldBg, {GestureTapCallback? onTap}) {
  return Builder(builder: (context) {
    return Container(
            color: textFieldBg,
            // color: AppColors.primaryLight,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: buildReplyProfile(context, false, post,
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
  BuildContext context,
  Color textFieldBg, {
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
      if (post != null) buildReplyField(post, textFieldBg, onTap: postOnCloseReply),
      3.verticalSpace,
      TextField(
        // onTapOutside: (event) => setState(() => sendNode.unfocus()),
        autofocus: post != null,
        controller: controller,
        style: AppStyles.text16PxRegular.white,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        textDirection: includeHeb ? TextDirection.rtl : TextDirection.ltr,
        textAlign: includeHeb ? TextAlign.right : TextAlign.left,
        cursorColor: AppColors.white,
        onChanged: (val) => stfSetState(() {}),
        decoration: InputDecoration(
            filled: true,
            // fillColor: AppColors.primaryLight,
            // fillColor: AppColors.darkOutline50,
            fillColor: textFieldBg,
            hintStyle: AppStyles.text14PxRegular.greyLight,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: buildSendButton(
              color: AppColors.greyLight,
              isActive:
                  controller.text.isNotEmpty && (controller.text.replaceAll(' ', '').isNotEmpty),
              onTap: onTap,
            )),
      )
          .roundedOnly(
            bottomLeft: 12,
            topLeft: post != null ? 3 : 12,
            topRight: post != null ? 3 : 12,
            bottomRight: 12,
          )
          .pOnly(bottom: 6),
    ],
  ).px(8);
}

Column buildReplyProfile(BuildContext context, bool currUser, PostModel post,
    {Widget? actionButton}) {
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
              shortName.toText(
                  fontSize: 14,
                  bold: true,
                  color: currUser ? AppColors.darkGrey : AppColors.greyLight,
                  softWrap: false),
              postAgo
                  .toText(color: currUser ? AppColors.darkGrey : AppColors.greyLight, fontSize: 11)
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
        style: AppStyles.text14PxRegular.copyWith(
          color: currUser ? AppColors.darkBg : AppColors.white,
        ),
        linkColor: AppColors.white,
      ).advancedSizedBox(context, maxWidth: true).pOnly(left: 50, bottom: 5, right: 45)
    ],
  );
}
