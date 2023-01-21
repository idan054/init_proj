import 'package:example/common/extensions/extensions.dart';
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
import '../../common/service/Database/firebase_database.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../widgets/app_bar.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({Key? key}) : super(key: key);

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  var splashLoader = true;
  List<ChatModel> chatList = [];

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    // splashLoader = true; setState(() {});
    var updatedList = <ChatModel>[
      ...await Database.advanced.handleGetModel(
        ModelTypes.chats,
        chatList,
        uid: context.uniProvider.currUser.uid,
      )
    ];
    print('updatedList ${updatedList.length}');
    if (updatedList.isNotEmpty) chatList = updatedList;
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
            return const CircularProgressIndicator(color: AppColors.primaryLight, strokeWidth: 3)
                .center;
          }

          if (chatList.isEmpty) {
            return 'Start a new chat \nfrom the Feed!'.toText().center;
          }

          return Container(
            color: AppColors.primaryDark,
            child: ListView(
              children: [
                10.verticalSpace,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatList.length,
                  itemBuilder: (context, i) {
                    if (chatList.isEmpty) {
                      return 'Your chats will be show here'.toText().center;
                    }

                    // var chatList = context.listenchatListModelList;
                    // WidgetsBinding.instance.addPostFrameCallback(
                    //         (_) => context.uniProvider.updateChatList(chatList));

                    var chat = chatList[i];
                    var otherUser = chat.users!.firstWhere((user) => user.uid != currUser.uid);

                    return Column(
                      children: [
                        ListTile(
                          onTap: () => ChatService.openChat(context, otherUser: otherUser),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          trailing: Column(
                            children: [
                              10.verticalSpace,
                              Text(
                                chat.lastMessage?.createdAt!.substring(9, 14) ?? '',
                                style: AppStyles.text12PxRegular.grey50,
                              )
                            ],
                          ),
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder)),
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
                  },
                ),
              ],
            ),
          );
        }));
  }
}
