import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_strings.dart';
import 'package:example/common/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    chatList = <ChatModel>[
      ...await Database.advanced.handleGetModel(context, ModelTypes.chats, chatList)
    ];
    splashLoader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('START: ChatsListScreen');
    var currUser = context.uniProvider.currUser;

    return Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: darkAppBar(context,
            title: 'Messages (${currUser.email})', // STR
            backAction: () => context.router.replace(const LoginRoute()),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.people,
                    color: AppColors.testGreen,
                  ),
                  onPressed: () => context.router.push(const MembersRoute()))
            ]),
        body: Builder(builder: (context) {
          if (splashLoader) {
            // First time only
            return const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 7).center;
          }

          if (chatList.isEmpty) {
            return 'Start a new chat \nfrom the Feed!'.toText().center;
          }

          return Container(
            color: AppColors.darkBlack,
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, i) {
                if (chatList.isEmpty) {
                  return const Text('chatList with this user will be show here').center;
                }

                // var chatList = context.listenchatListModelList;
                // WidgetsBinding.instance.addPostFrameCallback(
                //         (_) => context.uniProvider.updateChatList(chatList));

                var chat = chatList[i];
                var otherUser = chat.users!.firstWhere((user) => user.uid != currUser.uid);

                return ListTile(
                  trailing: Column(
                    children: [
                      10.verticalSpace,
                      Text(
                        chat.lastMessage?.createdAt!.substring(9, 14) ?? '',
                        style: AppStyles.text12PxRegular.greyLight,
                      )
                    ],
                  ),
                  leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(otherUser.photoUrl ?? AppStrings.monkeyPlaceHolder)),
                  onTap: () => ChatService.openChat(context, otherUser: otherUser),
                  title: Text(
                    otherUser.name ?? '',
                    style: AppStyles.text20PxSemiBold.white,
                  ),
                  subtitle: Text(
                    chat.lastMessage?.textContent ?? '',
                    style: AppStyles.text16PxRegular.greyLight,
                  ),
                ).ltr.appearOffset;
              },
            ),
          );
        }));
  }
}
