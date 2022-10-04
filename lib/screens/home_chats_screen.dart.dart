import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/models/chat/chat_model.dart';
import '../common/service/Auth/firebase_database.dart';
import '../common/service/Chat/chat_services.dart';
import '../widgets/app_bar.dart';

class HomeChatsScreen extends StatefulWidget {
  const HomeChatsScreen({Key? key}) : super(key: key);

  @override
  State<HomeChatsScreen> createState() => _HomeChatsScreenState();
}

class _HomeChatsScreenState extends State<HomeChatsScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: HomeChatsScreen');
    var currUser = context.uniProvider.currUser;

    return Scaffold(
        appBar: classicAppBar(context,
            title: currUser.email.toString(),
            leadingReplaceRoute: const LoginRoute(),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.people,
                    color: Colors.white,
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

            return Scaffold(
              backgroundColor: Colors.grey[100]!,
              body: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, i) {
                  if (chats.isEmpty) {
                    return const Text('Chats with this user will be show here')
                        .center;
                  }

                  var chat = chats[i];
                  var otherUser = chat.users!
                      .firstWhere((user) => user.uid != currUser.uid);

                  return Card(
                      child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(otherUser.photoUrl ??
                            AppStrings.monkeyPlaceHolder)),
                    onTap: () => ChatService().openChat(context,
                        otherUser: otherUser, chatId: chat.id),
                    title: Text(chat.lastMessage?.textContent ?? ''),
                    subtitle: chat.lastMessage?.createdAt.substring(9, 14).text,
                  )).rtl;
                },
              ),
            );
          },
        )).ltr;
  }
}
