import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class HomeChatsScreen extends StatefulWidget {
  const HomeChatsScreen({Key? key}) : super(key: key);

  @override
  State<HomeChatsScreen> createState() => _HomeChatsScreenState();
}

class _HomeChatsScreenState extends State<HomeChatsScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: HomeChatsScreen()');
    var user = context.uniModel.user;

    return Scaffold(
      appBar: classicAppBar(context,
          title: user.email.toString(),
          leadingReplaceRoute: const LoginRoute(),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                onPressed: () => context.router.replace(const MembersRoute()))
          ]),
      body: const Text('Chats with this user will be show here').center,
    ).ltr;
  }
}
