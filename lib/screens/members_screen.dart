import 'package:example/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/models/user/user_model.dart';
import '../common/service/Auth/firebase_database.dart';
import '../common/service/Chat/chat_services.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
      value: Database.streamUsers(),
      initialData: const [],
      builder: (context, child) {
        var users = context.listenUserModelList;
        return Scaffold(
          backgroundColor: Colors.grey[100]!,
          body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, i) {
              if (users[i].uid == context.uniModel.currUser.uid) {
                return const Offstage();
              }

              return Card(
                  child: ListTile(
                onTap: () =>
                    ChatService().newChat(context, otherUser: users[i]),
                title: Text(users[i].email ?? ''),
              ));
            },
          ),
        );
      },
    );
  }
}
