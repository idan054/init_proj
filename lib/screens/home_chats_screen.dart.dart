import 'dart:developer';
import 'dart:math';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';

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
      appBar: AppBar(
        elevation: 3,
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '${user.email}',
          style: AppStyles.text14PxBold.black,
        ),
        leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => context.router.replace(const LoginRoute())),
        actions: [
          // CustomButton(
          //         onPressed: () {},
          //         title: 'Add',
          //         backgroundColor: AppColors.primary)
          //     .px(12)
          //     .py(8)
          IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              onPressed: () => context.router.replace(const LoginRoute()))
        ],
      ),
      body: const Text('Chats with this user will be show here').center,
    ).ltr;
  }
}
