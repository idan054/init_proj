import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
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
    var currUser = context.uniModel.currUser;

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
            print('chats.length: ${chats.length}');

            return Scaffold(
              backgroundColor: Colors.grey[100]!,
              body: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, i) {
                  var chat = chats[i];
                  var otherUser = chat.users!
                      .firstWhere((user) => user.uid != currUser.uid);

                  if (chats.isEmpty) {
                    return const Text(
                            'Chats with this currUser will be show here')
                        .center;
                  }

                  return Card(
                      child: ListTile(
                    onTap: () =>
                        ChatService().newChat(context, otherUser: otherUser),
                    title: Text(chat.lastMessage?.textContent ?? ''),
                  ));
                },
              ),
            );
          },
        )).ltr;
  }
}
