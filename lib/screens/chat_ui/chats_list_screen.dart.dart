import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_strings.dart';
import 'package:example/common/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/models/chat/chat_model.dart';
import '../../common/service/Auth/firebase_database.dart';
import '../../common/service/Chat/chat_services.dart';
import '../../widgets/app_bar.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({Key? key}) : super(key: key);

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: HomeChatsScreen');
    var currUser = context.uniProvider.currUser;

    return Scaffold(
        appBar: darkAppBar(context,
            title: 'Messages', // STR
            backAction: () => context.router.replace(const LoginRoute()),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.people,
                    color: AppColors.testGreen,
                  ),
                  onPressed: () => context.router.push(const MembersRoute()))
            ]),
        body: StreamProvider<List<ChatModel>>.value(
          value: Database.streamChats(currUser.uid!),
          initialData: const [],
          builder: (context, child) {
            var chats = context.listenChatsModelList;
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => context.uniProvider.updateChatList(chats));

            return Container(
              color: AppColors.darkBlack,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, i) {
                  if (chats.isEmpty) {
                    return const Text('Chats with this user will be show here')
                        .center;
                  }

                  var chat = chats[i];
                  var otherUser = chat.users!
                      .firstWhere((user) => user.uid != currUser.uid);

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
                        backgroundImage: NetworkImage(otherUser.photoUrl ??
                            AppStrings.monkeyPlaceHolder)),
                    onTap: () => ChatService().openChat(context, otherUser: otherUser),
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
          },
        )).ltr;
  }
}
