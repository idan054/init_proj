import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../common/themes/app_colors.dart';
import '../common/themes/app_styles.dart';

AppBar darkAppBar(BuildContext context,
    {required String title,
    VoidCallback? backAction,
    List<Widget> actions = const []}) {
  Widget backButton(VoidCallback onPressed) => IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      );
  return AppBar(
    elevation: 0,
    titleSpacing: 0.0,
    backgroundColor: AppColors.darkBg,
    title: Text(
      title,
      style: AppStyles.text18PxRegular.white,
    ),
    leading: backAction != null
        ? backButton(backAction)
        : backButton(() async => await context.router.pop()),
    actions: actions,
  );
}
