import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/models/chat/chat_model.dart';
import '../common/models/user/user_model.dart';
import '../common/service/Auth/firebase_database.dart';
import '../common/service/Chat/chat_services.dart';
import '../widgets/app_bar.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: classicAppBar(context, title: 'Members page'),
      backgroundColor: Colors.grey[100]!,
      body: StreamProvider<List<UserModel>>.value(
          value: Database.streamUsers(),
          initialData: const [],
          builder: (context, child) {
            // A list of users to start new chat with.
            var users = context.listenUserModelList;
            // A list of active chats.
            var chats = context.uniProvider.chatList;
            // Remove users who already have chats.
            users = _filterUsers(users, chats);

            print('users.length ${users.length}');
            if (users.isEmpty || (users.length == 1)) {
              return const Text(
                'No new users found to start a chat',
              ).center;
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                if (users[i].uid == context.uniProvider.currUser.uid) {
                  return const Offstage();
                }

                return Card(
                    child: ListTile(
                  onTap: () =>
                      ChatService().openChat(context, otherUser: users[i]),
                  title: Text(users[i].email ?? ''),
                ));
              },
            );
          }),
    ).ltr;
  }

  List<UserModel> _filterUsers(List<UserModel> users, List<ChatModel>? chats) {
    var filteredUserList = users;
    chats?.forEach((chat) {
      chat.users?.forEach((chatUser) {
        if (users.contains(chatUser)) {
          filteredUserList.remove(chatUser);
        }
      });
    });
    return filteredUserList;
  }
}
