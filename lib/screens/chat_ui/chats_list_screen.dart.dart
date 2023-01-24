// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_strings.dart';
import 'package:example/common/themes/themes.dart';
import 'package:example/widgets/components/postBlock_sts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../common/models/chat/chat_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../widgets/app_bar.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({Key? key}) : super(key: key);

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  var splashLoader = true;
  bool initLoader = true;
  List<ChatModel> chatList = [];
  Future? listenLoadMore;

  @override
  void initState() {
    // TODO: ADD ON POST MVP ONLY: Get 1 doc instead all users chat.
    // this listener is based Database.streamUnreadCounter(context),
    // add a 'lastMessageFromId' field in UserModel to get only the need to update doc!

    // _loadMore();

    // listenLoadMore = _loadMore(refresh: true);
    //> Uncomment this to auto refresh chats when new message coming
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        // context.uniProvider.addListener(() => listenLoadMore)
        context.uniProvider.addListener(() => _loadMore(refresh: true)));

    super.initState();
  }

  // @override
  // void dispose() {
  //   // context.uniProvider.removeListener(() => listenLoadMore);
  //   super.dispose();
  // }

  Future _loadMore({bool refresh = false}) async {
    print('START: CHAT _loadMore()');
    if (!mounted) return;
    // await Future.delayed(100.milliseconds);
    splashLoader = true;
    setState(() {});
    if (refresh) chatList = [];
    var updatedList = <ChatModel>[
      ...await Database.advanced.handleGetModel(
        ModelTypes.chats,
        chatList,
        uid: context.uniProvider.currUser.uid,
      )
    ];
    print('updatedList ${updatedList.length}');
    if (updatedList.isNotEmpty) chatList = updatedList;
    // initLoader = false;
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: ChatsListScreen');
    var currUser = context.uniProvider.currUser;

    return Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: darkAppBar(
          context, title: 'Conversations',
          hideBackButton: true,
          //     backAction: () async {
          //   await FirebaseAuth.instance.signOut();
          //   await GoogleSignIn().signOut();
          //   context.router.replace(const LoginRoute());
          // },
          // actions: [
          //   IconButton(
          //       icon: Icon(
          //         Icons.people,
          //         color: AppColors.testGreen,
          //       ),
          //       onPressed: () => context.router.push(const MembersRoute()))
          // ]
        ),
        body: Builder(builder: (context) {
          if (splashLoader) {
            // First time only
            return const CircularProgressIndicator(
              color: AppColors.primaryLight,
              strokeWidth: 3,
            ).center;
          }

          if (chatList.isEmpty) {
            return 'Reply Ril to start new chat!'.toText(color: AppColors.grey50).center;
          }

          return Container(
            color: AppColors.primaryDark,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: chatList.length,
              itemBuilder: (context, i) {
                if (chatList.isEmpty) {
                  return 'Your conversations \nwill be show here'.toText().center;
                }

                // var chatList = context.listenchatListModelList;
                // WidgetsBinding.instance.addPostFrameCallback(
                //         (_) => context.uniProvider.updateChatList(chatList));

                var chat = chatList[i];
                var otherUser = chat.users!.firstWhere((user) => user.uid != currUser.uid);

                return StatefulBuilder(builder: (_context, stfSetState) {
                  return ChatBlockSts(chat, otherUser, onTap: () {
                    var currUser = context.uniProvider.currUser;
                    ChatService.clearUnread(currUser.unreadCounter, currUser.email, chat);
                    chat = chat.copyWith(unreadCounter: 0);
                    chatList[i] = chat;
                    // stfSetState(() {});

                    // var chatId = ChatService.openChat(context, otherUser: otherUser); // no need
                    context.router
                        .push(ChatRoute(otherUser: otherUser, chatId: chat.id!, chat: chat));
                  });
                });
              },
            ).pOnly(top: 10),
          );
        }));
  }
}

class ChatBlockSts extends StatelessWidget {
  final GestureTapCallback? onTap;
  final ChatModel chat;
  final UserModel otherUser;

  const ChatBlockSts(this.chat, this.otherUser, {this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    // Make sure currUser doesn't send the last message
    var showUnreadCount = (chat.lastMessage?.fromId != currUser.uid) &&
        chat.unreadCounter != null &&
        chat.unreadCounter != 0;
    // print('showUnreadCount ${showUnreadCount}');

    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          trailing: Column(
            children: [
              10.verticalSpace,
              Text(
                chat.lastMessage?.createdAt!.substring(9, 14) ?? '',
                style: AppStyles.text12PxRegular.grey50,
              ),
              10.verticalSpace,
              if (showUnreadCount)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.errRed,
                  child: chat.unreadCounter.toString().toText(fontSize: 12),
                )
            ],
          ),
          leading: Stack(
            children: [
              CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      NetworkImage(otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder)),
              buildOnlineBadge(ratio: 1.0)
            ],
          ),
          title: Text(
            otherUser.name ?? '',
            style: AppStyles.text16PxSemiBold.white,
          ),
          subtitle: Text(
            chat.lastMessage?.textContent ?? '',
            // textAlign: (chat.lastMessage?.textContent?.isHebrew ?? false) ? TextAlign.right : TextAlign.left,
            textAlign: TextAlign.left,
            maxLines: 2,
            style: AppStyles.text14PxRegular.copyWith(color: AppColors.greyLight),
          ),
        ).ltr.appearOpacity,
        const Divider(thickness: 2, color: AppColors.darkOutline),
      ],
    );
  }
}
