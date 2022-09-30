import 'dart:developer';
import 'dart:math';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_button.dart';

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
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          '${user.email}',
          style: AppStyles.text14PxBold.black,
        ),
        actions: [
          CustomButton(
                  onPressed: () {},
                  title: 'Add',
                  backgroundColor: AppColors.primary).px(12).py(8)
        ],
      ),
      body: InkWell(
        onTap: () {},
        child: FlutterLogo(
          size: 100.w,
        ).center,
      ),
    ).ltr;
  }
}
