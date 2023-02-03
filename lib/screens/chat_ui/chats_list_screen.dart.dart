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
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../common/extensions/color_printer.dart';
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

  // todo POST call creatorUser doc on initState
  // to make sure data is updated (not old after user edit)
  // also use users cubit so it will GET every user once each session

  void listenLoadMore() => _loadMore(refresh: true);

  @override
  void initState() {
    // TODO: ADD ON POST MVP ONLY: Get 1 doc instead all users chat.
    // this listener is based Database.streamUnreadCounter(context),
    // add a 'lastMessageFromId' field in UserModel to get only the need to update doc!
    //> Uncomment this to auto refresh chats when new message coming
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.uniProvider.addListener(listenLoadMore));
    super.initState();
  }

  // @override
  // void dispose() {
  //   context.uniProvider.removeListener(listenLoadMore);
  //   super.dispose();
  // }

  Future _loadMore({bool refresh = false}) async {
    if (!mounted) return;
    print('START: CHAT _loadMore()');
    // await Future.delayed(100.milliseconds);
    splashLoader = true;
    setState(() {});
    if (refresh) chatList = [];
    var updatedList = <ChatModel>[
      ...await Database.advanced.handleGetModel(
        context,
        ModelTypes.chats,
        chatList,
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
    // context.listenUniProvider..currUser.unreadCounter; // Rebuilt when get new message

    return Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: darkAppBar(
          centerTitle: true,
          context, title: 'Members messages',
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
          if (splashLoader && chatList.isEmpty) {
            // First time only
            return const CircularProgressIndicator(color: AppColors.primaryLight, strokeWidth: 3)
                .center;
          }

          if (chatList.isEmpty) {
            return 'Reply Ril to start new chat!'.toText(color: AppColors.grey50).center;
          }

          return Container(
            color: AppColors.primaryDark,
            child: LazyLoadScrollView(
              scrollOffset: 500,
              onEndOfPage: () async {
                printGreen('START: chat_list_screen.dart onEndOfPage()');
                // context.uniProvider.updateIsLoading(true);
                await _loadMore();
                // context.uniProvider.updateIsLoading(false);
              },
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

                  ChatModel chat = chatList[i];
                  var otherUser = chat.users!.firstWhere((user) => user.uid != currUser.uid);

                  return StatefulBuilder(builder: (_context, stfSetState) {
                    return ChatBlockSts(chat, otherUser, onTap: () async {
                      if (!mounted) return;
                      chatList[i] = chat;
                      // var chatId = ChatService.openChat(context, otherUser: otherUser); // no need
                      await context.router
                          .push(ChatRoute(otherUser: otherUser, chatId: chat.id!, chat: chat));
                      if (_context.uniProvider.activeChat != null) {
                        print('START: stfSetState()');
                        chat = _context.uniProvider.activeChat!;
                        stfSetState(() {});
                      }
                    });
                  });
                },
              ).pOnly(top: 10),
            ),
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
              // CircleAvatar(
              Container(
                  // radius: 28,
                  height: 56,
                  width: 56,
                  color: AppColors.darkBg,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder,
                    fit: BoxFit.cover,
                  )).roundedFull,
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
